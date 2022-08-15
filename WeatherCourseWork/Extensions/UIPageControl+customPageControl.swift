//
//  UIPageControl+customPageControl.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 15.08.2022.
//
// https://stackoverflow.com/questions/35842040/add-border-for-dots-in-uipagecontrol

import UIKit

extension UIPageControl {
    func customPageControl(dotFillColor:UIColor, dotBorderColor:UIColor, dotBorderWidth:CGFloat) {
        guard let container = subviews.first?.subviews.first else {
            return
        }
        for (pageIndex, dotView) in container.subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.backgroundColor = dotFillColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
            } else{
                dotView.backgroundColor = .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            }
        }
    }
}
