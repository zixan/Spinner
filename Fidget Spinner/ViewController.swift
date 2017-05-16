//
//  ViewController.swift
//  Fidget Spinner
//
//  Created by Zeeshan Mughal on 5/14/17.
//  Copyright © 2017 Footbits Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

	var audioPlayer = AVAudioPlayer()
	
	var upCount: CGFloat = 120
	var downCount: CGFloat = 120
	
	let spinner: UIImageView = {
		let image = UIImage(named: "four_sides_spinner")
		let imageView = UIImageView(image: image!)
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		return imageView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupAudio()
		setupViews()
//		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//			
//			cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
//			
//		}, completion: nil)
	
//		[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//			[self.imageView setTransform:CGAffineTransformRotate(self.imageView.transform, M_PI_2)];
//			}completion:^(BOOL finished){
//			if (finished) {
//			[self rotateImageView];
//			}
//			}];
	}
	
	func setupViews() {
		view.backgroundColor = .white
		view.addSubview(spinner)
		
		spinner.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 40, leftConstant: 40, bottomConstant: 40, rightConstant: 40, widthConstant: view.frame.width - 80, heightConstant: 0)
		
		let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
		swipeUp.direction = UISwipeGestureRecognizerDirection.up
		
		let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
		swipeDown.direction = UISwipeGestureRecognizerDirection.down
		
		view.addGestureRecognizer(swipeUp)
		view.addGestureRecognizer(swipeDown)
	}
	
	func respondToSwipeGesture(gesture: UIGestureRecognizer) {
		if let swipeGesture = gesture as? UISwipeGestureRecognizer {
			switch swipeGesture.direction {
			case UISwipeGestureRecognizerDirection.right:
				print("Swiped right")
			case UISwipeGestureRecognizerDirection.down:
				upCount += 1.00
				spin(direction: 1.00, count: 120)
				//playInfinitely()
			case UISwipeGestureRecognizerDirection.left:
				print("Swiped left")
			case UISwipeGestureRecognizerDirection.up:
				downCount += 1.00
				spin(direction: -1.00, count: 120)
				//playInfinitely()
			default:
				break
			}
		}
	}
	
	var c: CGFloat = 0
	
	func spin(direction: CGFloat, count: CGFloat) {
		
		if !audioPlayer.isPlaying {
			audioPlayer.play()
		}
		
		
		print(direction)
		
		c += 1.00
		
//		30.00 * count * direction
		
//		1 rotation in 0.1 secs
//		how many rotations in 60 * 2 secs?
//		60 * 2 / 0.1
//		(60 * 2 / 0.1) * 360
		
		UIView.animate(withDuration: 0.00001, delay: 0, options: .curveLinear, animations: ({
			self.spinner.transform = CGAffineTransform(rotationAngle: 360 * self.c)
		}), completion: { (finished: Bool) in
			print(count)
//			if count > 0 {
				self.spin(direction: direction, count: count - 1)
			
//			}
		})
		
		
		
//		UIView.animate(withDuration: 10, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
//			self.spinner.transform  = CGAffineTransform(rotationAngle: CGFloat.pi * 2 * direction)
//			self.spinner.transform = CATransform3DGetAffineTransform(
//			CATransform3DMakeScale(3, 3, 3)
//			self.spinner.transform = self.spinner.transform.rotated(by: CGFloat.pi * 2 * direction)

//			print("fsdfs")
//		}, completion: nil)
	}

	func setupAudio() {
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sample", ofType: "mp3")!))
			audioPlayer.numberOfLoops = -1
			audioPlayer.prepareToPlay()
		} catch {
			print(error)
		}
		
	}
	
	func playInfinitely() {
		while true {
			if !audioPlayer.isPlaying {
				audioPlayer.play()
			}
		}
	}
	
}

extension CGPoint {
	func distanceCount(_ point: CGPoint) -> CGFloat {
		return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
	}
}

