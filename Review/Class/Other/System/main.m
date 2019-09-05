//
//  main.m
//  Review
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <dlfcn.h>
#import <sys/sysctl.h>
#import <mach-o/loader.h>
#import <mach-o/dyld.h>
#import <mach-o/arch.h>

#import <objc/runtime.h>


#ifndef PT_DENY_ATTACH
#define PT_DENY_ATTACH 31
#endif
typedef int  (*ptrace_ptr_t)(int _request,pid_t pid,caddr_t _addr,int _data);

void disable_gdb() {
#ifndef DEBUG
    void *handle = dlopen(0, RTLD_NOW|RTLD_GLOBAL);
    ptrace_ptr_t ptrace_ptr = (ptrace_ptr_t)dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH,0,0,0);
    
    syscall(26, 31, 0, 0);
#endif
}


BOOL existDebugger() {
    int name[4];//指定查询信息的数组
    struct kinfo_proc info;//查询的返回结果
    size_t info_size = sizeof(info);
    info.kp_proc.p_flag = 0;

    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID;
    name[3] = getpid();
    if (sysctl(name, 4, &info, &info_size, NULL, 0) == -1) {
        NSLog(@"sysctl error ...");
        return NO;
    }
    return ((info.kp_proc.p_flag & P_TRACED) != 0);
}



/**
 注入检测
 */
BOOL AMCheckInjector(){
    int count = _dyld_image_count();
    for (int i = 0; i < count; i++) {
        // 遍历拿到库名称！
        const char * imageName = _dyld_get_image_name(i);
        // 判断是否在白名单内,应用本身的路径是不确定的,所以要除外.
        printf("\n----%s----\n", imageName);
//        if (!strstr(libraries, imageName)&&!strstr(imageName, "/var/mobile/Containers/Bundle/Application")) {
//            printf("该库非白名单之内！！\n%s",imageName);
//            return NO;
//        }
    }
    return YES;
}


/**
 hook检测

 @param clsname 类名
 @param selname 方法名
 */
bool CheckHookForOC(const char* clsname,const char* selname){
    Dl_info info;
    SEL sel = sel_registerName(selname);
    Class cls = objc_getClass(clsname);
    Method method = class_getInstanceMethod(cls, sel);
    if(!method){
        method = class_getClassMethod(cls, sel);
    }
    IMP imp = method_getImplementation(method);
    
    if(!dladdr((void*)imp, &info)){
        return false;
    }
    
    printf("%s\n", info.dli_fname);
    
    if(!strncmp(info.dli_fname, "/System/Library/Frameworks", 26)){
        return false;
    }
    
    if(!strcmp(info.dli_fname, _dyld_get_image_name(0))){
        return false;
    }
    
    return true;
}


/**
 重签名检查

 @param id BoundID
 */
void  checkCodesign(NSString *id){
    // 描述文件路径
    NSString *embeddedPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    // 读取application-identifier  注意描述文件的编码要使用:NSASCIIStringEncoding
    NSString *embeddedProvisioning = [NSString stringWithContentsOfFile:embeddedPath encoding:NSASCIIStringEncoding error:nil];
    NSArray *embeddedProvisioningLines = [embeddedProvisioning componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for (int i = 0; i < embeddedProvisioningLines.count; i++) {
        if ([embeddedProvisioningLines[i] rangeOfString:@"application-identifier"].location != NSNotFound) {
            
            NSInteger fromPosition = [embeddedProvisioningLines[i+1] rangeOfString:@"<string>"].location+8;
            
            NSInteger toPosition = [embeddedProvisioningLines[i+1] rangeOfString:@"</string>"].location;
            
            NSRange range;
            range.location = fromPosition;
            range.length = toPosition - fromPosition;
            
            NSString *fullIdentifier = [embeddedProvisioningLines[i+1] substringWithRange:range];
            NSArray *identifierComponents = [fullIdentifier componentsSeparatedByString:@"."];
            NSString *appIdentifier = [identifierComponents firstObject];
            
            // 对比签名ID
            if (![appIdentifier isEqual:id]) {
                //exit
//                asm(
//                    "mov X0,#0\n"
//                    "mov w16,#1\n"
//                    "svc #0x80"
//                    );
            }
            break;
        }
    }
}


int main(int argc, char * argv[]) {
    @autoreleasepool {
//        NSLog(@"----%i----", existDebugger());
//
//        CheckHookForOC("MainViewController", "viewDidLoad");
//        disable_gdb();
//        AMCheckInjector();
//
//        char *env = getenv("DYLD_INSERT_LIBRARIES");
//        NSLog(@"%s", env);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
