# 简述


SKCalendarView是一个高可控性的日历基础组件，为了提高应用的自由度，默认只提供了日历部分的视图封装，但不涵盖切换月份按钮、年月分显示等非关键性控件，但请不要担心，SKCalendarView为你提供了多样性的API，你可以很轻松的拿到这些信息去展示在你自己的自定义控件中。不仅如此，SKCalendarView还为你封装了公历、农历、节假日以及中国24节气的核心算法，即使你觉得默认的视图并不合胃口，也可以直接快速的利用这套算法创造出一个全新的日历控件。最后，SKCalendarView还提供了一些简单的切换动画，如果你不喜欢它，可以忽略掉，用自己的，这里完全不会受到任何限制。

![Language](https://img.shields.io/badge/Language-%20Objective%20C%20-blue.svg) 


### 效果图 
<img src="http://ofg0p74ar.bkt.clouddn.com/SKCalendarView.gif" width="370" height ="665" />


# 如何开始 


1.从GitHub上Clone-->SKCalendarView, 然后查看Demo (由于使用cocoaPods管理，请打开xcworkspace工程进行查看)


2.在项目中使用SKCalendarView，直接将目录下的SKCalendarView文件夹拷贝到工程中，或在podfile文件中添加```pod 'SKCalendarView'```

3.SKCalendarView的默认视图基于Masonry布局，如果需要使用, 请确保你的工程里已存在Masonry，[下载地址](https://github.com/SnapKit/Masonry)


# 使用方法
