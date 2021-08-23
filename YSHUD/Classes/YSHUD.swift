
import MBProgressHUD

@objc open class HUD: NSObject {
    
    /// 加载
    /// - Parameters:
    ///   - text: 要显示的文字
    ///   - view: 展示的视图
    ///   - blur: 背景是否模糊处理
    ///   - effectStyle: 模糊效果的风格(仅在blur为true时有效)
    @objc open class func showLoading(_ text: String? = nil, on view: UIView? = nil, blur: Bool = false, effectStyle: UIBlurEffect.Style = .dark) {
        getMainThread {
            let onView: UIView?
            if let view = view {
                onView = view
            } else {
                onView = keyWindow()
            }
            guard let view = onView else { return }
            hide()
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            if blur {
                hud.backgroundView.style = .blur
                hud.backgroundView.blurEffectStyle = effectStyle
            }
            hud.label.text = text
            hud.removeFromSuperViewOnHide = true
            hud.defaultStyle()
        }
    }
    
    /// 信息+文字
    /// - Parameters:
    ///   - text: 要显示的文字
    ///   - icon: 要显示的图标
    ///   - view: 展示的视图
    ///   - delay: 延迟隐藏的时间, ==0则不隐藏
    ///   - closure: 隐藏后的回调
    @objc open class func show(_ text: String?, icon: String?, on view: UIView? = nil, hideAfter delay: TimeInterval = 1.5, completed closure: (() -> Void)? = nil) {
        getMainThread {
            let onView: UIView?
            if let view = view {
                onView = view
            } else {
                onView = keyWindow()
            }
            guard let view = onView else { return }
            hide()
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .customView
            hud.label.numberOfLines = 0
            hud.label.text = text
            if let icon = icon {
                hud.customView = UIImageView(image: UIImage(named: icon))
            }
            hud.removeFromSuperViewOnHide = true
            hud.completionBlock = closure
            hud.defaultStyle()
            if delay > 0 {
                hud.hide(animated: true, afterDelay: delay)
            }
        }
    }
    
    /// 信息
    /// - Parameters:
    ///   - text: 要显示的文字
    ///   - view: 展示的视图
    ///   - delay: 延迟隐藏的时间, ==0则不隐藏
    ///   - closure: 隐藏后的回调
    @objc open class func showMessage(_ text: String?, on view: UIView? = nil, hideAfter delay: TimeInterval = 1.5, complated closure: (() -> Void)? = nil) {
        show(text, icon: nil, on: view, hideAfter: delay, completed: closure)
    }
    
    /// 成功
    /// - Parameters:
    ///   - text: 要显示的文字
    ///   - view: 展示的视图
    ///   - delay: 延迟隐藏的时间, ==0则不隐藏
    ///   - closure: 隐藏后的回调
    @objc open class func showSucceed(_ text: String?, on view: UIView? = nil, hideAfter delay: TimeInterval = 1.5, complated closure: (() -> Void)? = nil) {
        show(text, icon: "hud_succeed", on: view, hideAfter: delay, completed: closure)
    }
    
    /// 警告
    /// - Parameters:
    ///   - text: 要显示的文字
    ///   - view: 展示的视图
    ///   - delay: 延迟隐藏的时间, ==0则不隐藏
    ///   - closure: 隐藏后的回调
    @objc open class func showWarned(_ text: String?, on view: UIView? = nil, hideAfter delay: TimeInterval = 1.5, complated closure: (() -> Void)? = nil) {
        show(text, icon: "hud_warned", on: view, hideAfter: delay, completed: closure)
    }
    
    /// 失败
    /// - Parameters:
    ///   - text: 要显示的文字
    ///   - view: 展示的视图
    ///   - delay: 延迟隐藏的时间, ==0则不隐藏
    ///   - closure: 隐藏后的回调
    @objc open class func showFailed(_ text: String?, on view: UIView? = nil, hideAfter delay: TimeInterval = 1.5, complated closure: (() -> Void)? = nil) {
        show(text, icon: "hud_failed", on: view, hideAfter: delay, completed: closure)
    }
    
    /// 进度
    /// - Parameters:
    ///   - text: 要显示的文字
    ///   - view: 展示的视图
    ///   - progress: 进度, 进度>=1后0.2秒隐藏
    @objc open class func showProgressRound(_ text: String?, on view: UIView? = nil, _ progress: Float) {
        getMainThread {
            let onView: UIView?
            if let view = view {
                onView = view
            } else {
                onView = keyWindow()
            }
            guard let view = onView else { return }
            let hud: MBProgressHUD
            if let findHud = MBProgressHUD.forView(keyWindow()!) {
                hud = findHud
            } else {
                hud = MBProgressHUD.showAdded(to: view, animated: true)
            }
            hud.mode = .annularDeterminate
            hud.label.text = text
            hud.removeFromSuperViewOnHide = true
            hud.progress = progress
            hud.defaultStyle()
            if progress >= 1 {
                hud.hide(animated: true, afterDelay: 0.3)
            }
        }
    }
    
    /// 隐藏
    /// - Parameter view: 展示的视图
    @objc open class func hide(on view: UIView? = nil) {
        getMainThread {
            let onView: UIView?
            if let view = view {
                onView = view
            } else {
                onView = keyWindow()
            }
            guard let view = onView else { return }
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
    
    /// 在主线程执行
    /// - Parameter closure: 要执行的闭包
    private class func getMainThread(_ closure: @escaping () -> Void) {
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async {
                closure()
            }
        }
    }
    
    @objc class func keyWindow() -> UIView? {
        for window in UIApplication.shared.windows {
            if window.windowLevel == .normal {
                return window
            }
        }
        return UIApplication.shared.windows.last
    }
    
}

extension MBProgressHUD {
    
    @objc fileprivate func defaultStyle() {
        bezelView.style = .solidColor
        bezelView.color = UIColor(white: 0, alpha: 0.7)
        contentColor = .white
    }
    
}
