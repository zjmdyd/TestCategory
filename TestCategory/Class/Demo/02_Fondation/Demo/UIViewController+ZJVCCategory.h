//
//  UIViewController+ZJVCCategory.h
//  TestCategory
//
//  Created by ZJ on 12/05/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 分类中是不可以创建实例变量的，自然也不可以创建属性。
 在分类中是可以访问主类的属性，但不可以访问主类的实例变量。
 */
@interface UIViewController (ZJVCCategory)

- (void)addMethod;

@property (nonatomic, copy) NSString *value;

@end

/**
 (一)category特点
 
 category只能给某个已有的类扩充方法，不能扩充成员变量。
 category中也可以添加属性，只不过@property只会生成setter和getter的声明，不会生成setter和getter的实现以及成员变量。
 如果category中的方法和类中原有方法同名，运行时会优先调用category中的方法。也就是，category中的方法会覆盖掉类中原有的方法。所以开发中尽量保证不要让分类中的方法和原有类中的方法名相同。避免出现这种情况的解决方案是给分类的方法名统一添加前缀。比如category_。
 如果多个category中存在同名的方法，运行时到底调用哪个方法由编译器决定，最后一个参与编译的方法会被调用。
 
 3、调用优先级
 分类(category) > 本类 > 父类。即，优先调用cateory中的方法，然后调用本类方法，最后调用父类方法。
 注意：category是在运行时加载的，不是在编译时。
 
 4、为什么category不能添加成员变量？
 Objective-C类是由Class类型来表示的，它实际上是一个指向objc_class结构体的指针。它的定义如下：
 typedef struct objc_class *Class;
 objc_class结构体的定义如下：
 struct objc_class {
 Class isa  OBJC_ISA_AVAILABILITY;
 #if !__OBJC2__
 Class super_class                       OBJC2_UNAVAILABLE;  // 父类
 const char *name                        OBJC2_UNAVAILABLE;  // 类名
 long version                            OBJC2_UNAVAILABLE;  // 类的版本信息，默认为0
 long info                               OBJC2_UNAVAILABLE;  // 类信息，供运行期使用的一些位标识
 long instance_size                      OBJC2_UNAVAILABLE;  // 该类的实例变量大小
 struct objc_ivar_list *ivars            OBJC2_UNAVAILABLE;  // 该类的成员变量链表
 struct objc_method_list **methodLists   OBJC2_UNAVAILABLE;  // 方法定义的链表
 struct objc_cache *cache                OBJC2_UNAVAILABLE;  // 方法缓存
 struct objc_protocol_list *protocols    OBJC2_UNAVAILABLE;  // 协议链表
 #endif
 } OBJC2_UNAVAILABLE;
 在上面的objc_class结构体中，ivars是objc_ivar_list（成员变量列表）指针；methodLists是指向objc_method_list指针的指针。在Runtime中，objc_class结构体大小是固定的，不可能往这个结构体中添加数据，只能修改。所以ivars指向的是一个固定区域，只能修改成员变量值，不能增加成员变量个数。methodList是一个二维数组，所以可以修改*methodLists的值来增加成员方法，虽没办法扩展methodLists指向的内存区域，却可以改变这个内存区域的值（存储的是指针）。因此，可以动态添加方法，不能添加成员变量。
 
 
 5、Category不能添加成员变量（instance variables），那到底能不能添加属性（property）呢？
 
 这个我们要从Category的结构体开始分析：
 typedef struct category_t {
 const char *name;  //类的名字
 classref_t cls;  //类
 struct method_list_t *instanceMethods;  //category中所有给类添加的实例方法的列表
 struct method_list_t *classMethods;  //category中所有添加的类方法的列表
 struct protocol_list_t *protocols;  //category实现的所有协议的列表
 struct property_list_t *instanceProperties;  //category中添加的所有属性
 } category_t;
 从Category的定义也可以看出Category的可为（可以添加实例方法，类方法，甚至可以实现协议，添加属性）和不可为（无法添加实例变量）。
 
 实际上，Category实际上允许添加属性的，同样可以使用@property，但是不会生成_变量（带下划线的成员变量），也不会生成添加属性的getter和setter方法的实现，所以，尽管添加了属性，也无法使用点语法调用getter和setter方法（实际上，点语法是可以写的，只不过在运行时调用到这个方法时候会报方法找不到的错误，如下图）。但实际上可以使用runtime去实现Category为已有的类添加新的属性并生成getter和setter方法。
 
 三）category和extension的区别
 
 就category和extension的区别来看，我们可以推导出一个明显的事实，extension可以添加实例变量，而category是无法添加实例变量的（因为在运行期，对象的内存布局已经确定，如果添加实例变量就会破坏类的内部布局，这对编译型语言来说是灾难性的）。
 
 extension在编译期决议，它就是类的一部分，但是category则完全不一样，它是在运行期决议的。extension在编译期和头文件里的@interface以及实现文件里的@implement一起形成一个完整的类，它、extension伴随类的产生而产生，亦随之一起消亡。
 extension一般用来隐藏类的私有信息，你必须有一个类的源码才能为一个类添加extension，所以你无法为系统的类比如NSString添加extension，除非创建子类再添加extension。而category不需要有类的源码，我们可以给系统提供的类添加category。
 extension可以添加实例变量，而category不可以。
 extension和category都可以添加属性，但是category的属性不能生成成员变量和getter、setter方法的实现。
 */
