# NYTBooks Project - Team name: ShaCamYuTa 
Group Project

### Collaborators: Shaniya, Cameron, Yuliia, Tanya 


### Technologies:
Swift 5, Xcode 11, Git, UIKit, ImageIO, RESTful API, Memory Management (ARC), CocoaPods, UserDefaults, SafariServices, iOS Constraint Engine

### Description:
  This project displays the top ten books on the New York Times Best Sellers list. The user can choose which best selling books to display from a list of 59 categories. Once chosen, the user can browse the books and favourite any of them that appeal to them. If desired, they can even navigate to one of four online retailers to purchase the book.

  It was our first time working in a team environment, which presented its own set of difficulties and challenges, especially surrounding the use of git. However, we all navigated it very well, and learned a great deal from the experience.

### Demo Gifs:
| NYTimesBestSellers1 | NYTimesBestSellers2 | NYTimesBestSellers3 |
|---------------------|---------------------|---------------------|
|![gif](Assets/NYTimesBestSellers1.gif)|![gif](Assets/NYTimesBestSellers2.gif)|![gif](Assets/NYTimesBestSellers3.gif)|

### Challenges:
* Safari
* Lauch screen Gif
  We wanted to add an animated slpash screen to our app. This was a little challenging, locating information on how to make it possible. Essentially google, and the experienced coding team in our class helped make it possible. We used the built in launch screen to display the initial image of our gif, added an additional view that utilized the extension we added to UIView to play the gif. It would paly the gif for a short period of time, and then segue automatically to the rest of the app. 

The code that was a bit challenging was the timer, and its placement

```swift

class OpeningViewController: UIViewController {
    
    
    
    let logoAnimationView = InitialView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
      
            
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate = (scene?.delegate as? SceneDelegate) {
                UIView.transition(with: self.logoAnimationView,
                                  duration: 1.0,
                                           options: .transitionCrossDissolve,
                                           animations: nil,
                                           completion: nil)
                sceneDelegate.afterSplashScreenAnimation()
            }
        }
     
    }
````

### Team Image: 

![groupName](https://user-images.githubusercontent.com/55717900/74779867-5852fa00-526c-11ea-97c5-00ebc1d171d6.gif)


Thank you for reading



  ### - Sincerely Shacamyuta 
