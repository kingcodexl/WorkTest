//
//  ViewController.swift
//  SwfitAnimation
//
//  Created by renhe.cn on 15/10/13.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollisionBehaviorDelegate {
    //// 属性
    // UIKit物理引擎
    var animator: UIDynamicAnimator!;
    
    // 重力行为
    var gravity: UIGravityBehavior!;
    
    // 碰撞
    var collision: UICollisionBehavior!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var firstContact = false;
        // 创建一个方块
        let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100));
        square.backgroundColor = UIColor.cyanColor();
        self.view.addSubview(square);
        
        // 创建一个长方形View，颜色设置为红色，加入当前的View中
        let barrier = UIView(frame:CGRect(x: 0, y: 300, width: 140, height: 20));
        barrier.backgroundColor = UIColor.redColor();
        self.view.addSubview(barrier);
        
        // 将容器视图关联物理引擎,则子视图就会关联上物理引擎
        animator = UIDynamicAnimator(referenceView: self.view);
        // 子视图关于重力行为
        gravity = UIGravityBehavior(items: [square]);
        
        // 子视图关联碰撞行为
        // 加到碰撞中,关联碰撞行为
        collision = UICollisionBehavior(items: [square,barrier]);
        collision.collisionDelegate = self;
        /*
        public var angle: CGFloat
        public var magnitude: CGFloat
        上述代码中的angle是重力行为的角度属性，angle的值为0时，方块会水平向右移动，随着值的增大，方块会顺时针改变角度。不过我们要模拟现实中的重力，所以该属性一般不设置，不设置时默认是垂直向下移动。magnitude是重力行为的速率属性，值越大下降的速度越快，当magnitude属性的值为0时，方块就不会下降了，所以最小的速率是0.1。
        */
        // gravity.angle = 0;
        gravity.magnitude = 3;
        animator.addBehavior(gravity);
        // 将参考视图的边界作为碰撞边界
        collision.translatesReferenceBoundsIntoBoundary = true;
        
        // 将碰撞行为添加到UIKit物理引擎类中
        animator.addBehavior(collision);
        
        /*
        // 实例化UIKit物理引擎类，作用于ViewController的View
        animator = UIDynamicAnimator(referenceView: self.view);
        
        // 实例化重力行为类，目前只作用于刚才创建的正方形View
        gravity = UIGravityBehavior(items: [square]);
        
        // 将重力行为添加到UIKit物理引擎类中
        animator.addBehavior(gravity);
        */
        // 实例化碰撞行为类，目前只作用于刚才创建的正方形View
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrier.frame));
        
        
        // 碰撞背后的故事
        // 它的类型是一个函数（() -> Void），我们可以使用一个闭包来打印一下每一步行为的信息。
        collision.action = {
             print("\(NSStringFromCGAffineTransform(square.transform)) \(NSStringFromCGPoint(square.center))")
        }
        // 动态引擎通过不断改变ransform和center两个数据模型的数据来驱动View的行为。
        
        /*
        它描述了动作行为的数据模型，那就是UIDynamicItem，它遵循NSObjectProtocol协议。UIDynamicItem协议提供了两个可读写的属性center和transform，物体的运动轨迹靠这两个属性来计算。同时还提供了一个只读的属性bounds，该属性运动物体的边界，它用于描述碰撞物体的边界周长，这样就可以计算碰撞时该物体的受力大小，并做出相应的动作。
        
        因为UIDynamicItem是一个协议，所以这就说明了它与UIView是松耦合的关系。在UIKit中还有一个类遵循这个协议，就是UICollectionViewLayoutAttributes，这意味着动作引擎不但可以作用于一个View，还可以作用于一个集合中的View。
        */
        
        let itemBehaviour = UIDynamicItemBehavior(items: [square]);
        itemBehaviour.elasticity = 0.6;
        animator.addBehavior(itemBehaviour);
        /*
        在上面的代码中，我们只修改了弹力属性elasticity，其实还有其他的属性，我们来看一下：
        
        弹力（elasticity）：设置物体发生碰撞时的弹力，比如当物体碰撞时弹开的高度、角度的大小，物体的韧性等。
        摩擦力（friction）：设置物体滑动时的摩擦力。
        密度（density）：设置物体密度，密度越大加速度越大。
        阻力（resistance）：设置物体滑动时的阻力，与friction不同的是，它只作用于线性滑动时。
        角度阻力（angularResistance）：物体进行旋转运动时的阻力设置。
        允许旋转（allowsRotation）：该属性并不是模拟现实中的一些行为属性，它是物体是否可以旋转的开关属性。
        */
        
        if (!firstContact) {
            firstContact = true;
            
            let square1 = UIView(frame: CGRect(x: 30, y: 0, width: 100, height: 100));
            square1.backgroundColor = UIColor.grayColor();
            view.addSubview(square1);
            
            collision.addItem(square1);
            gravity.addItem(square1);
            // 将两个联系起来
            let attach = UIAttachmentBehavior(item: square1, attachedToItem:square);
            animator.addBehavior(attach);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func BehideView(){
        
    }
    
    // 这个方法在View每次发生碰撞时调用。我们让它在控制台打印一些信息。为了能更好的查看该方法中打印的信息
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {

        
        let collidingView = item1 as! UIView;
        collidingView.backgroundColor = UIColor.yellowColor();
        let aimCollidingView = item2 as! UIView;
        UIView.animateWithDuration(0.3) {
            collidingView.backgroundColor = UIColor.grayColor();
            aimCollidingView.backgroundColor = UIColor.blueColor()
        }
        
    }
    
}

class UIKITAnimation {
    
}

