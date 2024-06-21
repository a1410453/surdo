![Logo](https://github.com/a1410453/surdo/tree/master/surdo/App%20Resources/ForReadMe/App_Icon_150.png)
# Surdo - Application to learn Kazakh Sign Language
__Learn and practice sign language letters, words and numbers__

![Image](https://github.com/a1410453/surdo/tree/master/surdo/App%20Resources/ForReadMe/AppShowcase.png)

###Interesting Lessons
Alphabet Mastery: Learn the sign language alphabet through easy-to-follow lessons.
Numbers: Gain proficiency in signing individual numbers.

###Quizzes and Rankings
Challenge Yourself: Test your knowledge with interactive quizzes.
Track Your Progress: See how you rank against other learners and strive for the top.

###Real-Time Sign Identification
Camera Integration: Use your device's camera to identify sign letters in real-time.
Instant Feedback: Practice signing and receive immediate feedback to improve your accuracy.

### FOR DEVELOPERS
The project uses:

Core ML for sign recognition

Firebase for Authentication and Database

Combine framework to simplify some of the asynchronous actions

SDWebImage library for asyncronous image download

SnapKit for Auto Layout

It is based on MVC architecture and is fully open-source [documented](https://github.com/a1410453/surdo) on GitHub.

[![Download on the App Store](https://github.com/a1410453/surdo/tree/master/surdo/App%20Resources/ForReadMe/Download_on_the_App_Store_Badge_US_180px.png)](https://apps.apple.com/us/app/asl-recognizer/id1612140503)


## Features and Data Sets

The application uses __Kazakh Sign Language (KSL)__ machine learning based recognition model that is organized, trained, and tested via Xcode Create ML tools.

While the developer does not provide any related data sets, it is worth mentioning that the data set for this specific ML model that application uses consists of images (that were used for training and validation of an aforementioned ML model) provided by Anara Sandygulova https://krslproject.github.io/krsl20/
    [Mukushev, M., A. Sabyrov, A. Imashev, K. Koishybay, V. Kimmelman & A. Sandygulova. (2020). Evaluation of Manual and Non-manual Components for Sign Language Recognition. In Proceedings of The 12th Language Resources and Evaluation Conference, 6075-6080. Marseille, France: European Language Resources Association. https://www.aclweb.org/anthology/2020.lrec-1.745. ]
## What can be recognized?

KSL Recognizer detects only 29 alphabet letters. Hand gesture detection output is shown within the main application interface. Each detected symbol (letter or number) is added to the current value with previously detected symbols.

## Availability

The project is written on Xcode 15 __for iOS/iPadOS devices from iOS 15__.

## ML model

Accuracy:
* Training - 99 %
* Validation - 68 %

Training data:
* 29 classes
* 2268 items

⚠️ __It should be noted that detection of some letters is not ideal and may lead to letters being recognized as not the right ones. The ML model is set to be improved.__

## Prediction based on ML model from technical perspective

The application uses __Apple Vision__ framework to perform the hand gesture recognition with each camera output frame (__CMSampleBuffer__). Vision has hand pose visual detection request class that is used for hand pose and fingers recognition. Vision data parsing goes through __VNImageRequestHandler__.

Hand Pose ML model to predict a hand gesture uses __MLMultiArray__ as input. What is amazing here is that multi-dimensional array (__MLMultiArray__) can be extracted from Vision image request handler (__VNImageRequestHandler__) output directly, which then is passed to model prediction methods (they were generated directly in Xcode's Create ML application before).

Finally, after model finishes with prediction, the following can be extracted: prediction confidence, predicted result (label), and many more!


## Project architecture

Project relies on __MVC architecture__ (with own project modifications).

## Privacy permissions

User needs to grant these privacy permissions:
* Camera - Used for detecting and recognizing hand poses.

## Privacy Policy and support

If you have questions regarding this application or its support, please [contact](mailto:a1410453@gmail.com) the developer.


## App Images

App images has been designed using resources from [Flaticon.com](https://www.flaticon.com/).


## License

MIT License

__Copyright © 2024 Rustem Orazbayev.__

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
