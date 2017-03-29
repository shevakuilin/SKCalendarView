# 简述


SKArchCutter是一个可自选切割角的圆角切割工具，同时支持UIView、UIImageView、UIButton和UILabel的单角切圆/选角拱形切圆/全角切圆，并且避免了UIImageView使用系统圆角所导致的离屏渲染的问题，以及确保layer对象的masksToBounds属性始终为NO，从而使得项目中大量使用圆角时的性能得到很大程度的优化, 最重要的是使用简单、方便。如果觉得还不错，star支持下吧~



### 效果图 
<img src="http://ofg0p74ar.bkt.clouddn.com/SKArchCutter.png" width="370" height ="665" />


### 测试性能
<img src="http://ofg0p74ar.bkt.clouddn.com/SKArchCutter.gif" width="370" height ="665" />



# 如何开始


1.从GitHub上Clone-->SKArchCutter，然后查看Demo

2.直接将目录下的SKArchCutter拷贝到工程中，或在podfile文件夹中添加 ```pod 'SKArchCutter'```

3.如果觉得还不错，点个star吧~


# 使用方法

#### 头文件导入
```objectivec
#import "SKArchCutter.h"
```

#### 初始化
```objectivec
SKArchCutter * archCutter = [[SKArchCutter alloc] init];
```

#### 进行圆角切割
```objectivec
[archCutter cuttingWithObject:self.myImageView direction:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:10];
```



### 感谢你花时间阅读以上内容, 如果这个项目能够帮助到你，记得告诉我


Email: shevakuilin@gmail.com
