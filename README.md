# ReactiveSwift试用

### KVO setter

2016年11月27日 上午11:21

当usernamelable.text做修改时，自动observeValues变化

```
let nameLabelSignal = usernameLabel.reactive.trigger(for: #selector(setter: usernameLabel.text))
            .map { [weak usernameLabel] in usernameLabel!.text }
            .take(during: self.reactive.lifetime)
nameLabelSignal.observeValues { [unowned self] value in
    print("got \(value)")
    if let value = value {
        self.vm.username.value = value
    }
}
```

### 使用 <~ 绑定

2016年11月26日 下午8:59

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

### 一个订阅

2016年11月9日 下午7:11

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

### 安装

2016年10月31日 上午10:45

只用Swift?不掺进Objc? 感觉这个rac_textSingal这种都没有了？原来还是要集成ReactiveCocoa框架

```
carthage update 
```

### 引入头部文件

直接引入头部文件，就可以了。继续使用原来的一切方法。

```
import Result
import ReactiveCocoa
import ReactiveSwift
```

