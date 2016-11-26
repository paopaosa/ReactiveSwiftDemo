# ReactiveSwift试用

### 2016年11月26日 下午8:59

学习使用 <~ 绑定

```
class HomeViewModel {
    let username = MutableProperty("") ///< 定义一个属性username，类型字符串
}

class HomeViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    var vm = HomeViewModel()

    override func viewDidLoad {
        super.viewDidLoad()
        
        // 绑定vm.username至界面上的self.usernameLabel
        self.usernameLabel.reactive.text <~ self.vm.username
    }
}
```

### 2016年11月9日 下午7:11
一个订阅

```
self.name.reactive.continuousTextValues
    .observe(on: UIScheduler())
    .observe { event in
        switch event {
        case let .value(results):
            print("name input is \(results!)")
        case let .failed(error):
            print("name input error \(error)")
        case .completed, .interrupted:
            break
        }
}
```

### 2016年10月31日 上午10:45

只用Swift?不掺进Objc? 感觉这个rac_textSingal这种都没有了？原来还是要集成ReactiveCocoa框架

### 安装

```
carthage update 
```

### 使用

直接引入头部文件，就可以了。继续使用原来的一切方法。

```
import Result
import ReactiveCocoa
import ReactiveSwift
```

