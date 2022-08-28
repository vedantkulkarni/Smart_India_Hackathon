<div id="top"><div>
<!-- PROJECT LOGO -->
<div align="center">
  <a href="https://summerofcode.withgoogle.com/">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/GSoC-icon.svg/512px-GSoC-icon.svg.png?20190503110706" alt="Logo" width="80" height="80">
  </a>

  <h2 align="center"><strong>ROLL CALL</strong></h2>

  <p align="center">Mark and monitor attendance in a smooth and secure manner.</p>
  <strong>·</strong>
    <a href="" download rel="noopener noreferrer" target="_blank" >
      Download Apk
    </a>
    &nbsp &nbsp &nbsp &nbsp
   <strong>·</strong>
    <a href="https://github.com/vedantkulkarni/GSOC_Organizations_App/issues">Report Bug</a>
    &nbsp &nbsp &nbsp &nbsp
     <strong>·</strong>
    <a href="https://github.com/vedantkulkarni/GSOC_Organizations_App/issues">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#some-resources-to-get-you-going">Resources to checkout</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

This is the project made by the team **Dart Knights** during the grand finale of the **'Smart India Hackathon 2022'**. Problem statement for the project was given by **Government of Maharashtra**.

### Team Members:
<p>1. <a href="https://github.com/vedantkulkarni">Vedant Kulkarni </a>(Team Leader)</p>
<p>2. <a href="https://github.com/atharv-bhadange">Atharv Bhadange </a></p>
<p>3. <a href="https://github.com/Harshwardhan431">Harshwardhan Atkare </a></p>
<p>4. <a href="https://github.com/Koosta02">Namit Surana </a></p>
<p>5. <a href="">Anshree Bajaj </a></p>
<p>6. <a href="https://github.com/suyogkokaje">Suyog Kokaje </a></p>

### Problem Statement :

<p>Every year number of students take admissions into government aided schools. Currently the attendance system for the students is done manually. 
Hence requirement of a robust and low-cost system is needed. Addressing this problem will ensure the proper attendance and will help teachers in taking attendance.
</p>

## Screenshots

|                                                                        |                                                                        |
| ---------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| <img src="./mockups/Google Pixel 4 XL Screenshot 0.png" height="750"/> | <img src="./mockups/Google Pixel 4 XL Screenshot 1.png" height="750"/> |

|                                                                        |                                                                        |
| ---------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| <img src="./mockups/Google Pixel 4 XL Screenshot 2.png" height="750"/> | <img src="./mockups/Google Pixel 4 XL Screenshot 3.png" height="750"/> |

<br/>

### Features:
<strong>1. Face Detection and Recognition: </strong>
<p> Attendance is marked by scanning student's face through the app. Teacher can also mark attendance of more than one students at a time by scanning multiple faces simultaneously. FaceNet is used for that purpose. You can read more about FaceNet <a href="https://arxiv.org/pdf/1503.03832.pdf">here</a>.</p>
<strong>2. Robust Search Filters: </strong>
<p> You can get any specific inofrmation regarding attendacne of any student you want according to your need by appying various search filters. This feature is implemented using AWS Opensearch.</p>
<strong>3. Teacher's location verification: </strong>
<p> Location of the teacher will be recorded while marking the attendance of the students.</p>
<strong>4. Graphical Statistics: </strong>
<p> Various kind of information regarding the attendance is displayed in the form of different graphs such as bar graphs, pie charts, etc.</p>
<strong>5. OneTap Attendance: </strong>
<p> In case if some kind of glitch is introduces while scanning the face, then teacher can take attendance manually just by tapping on the student card. By default all students will be marked present. If any of the students is absent then teacher have to tap on his profile card to mark it as absent.</p>
<strong>5. Downloadable Attendance Report: </strong>
<p> Once the attendance is recorded, the report of the attendance can be downloaded in the form of .csv file</p>
<strong>6. (Write appropriate name for the feature): </strong>
<p> At some places there is the issue of the connectivity. So it is not possible to upload the attendance instantly. This app provides facility to submit the attendance instantly. The attendance is stored locally until the connectivity is recovered.</p>



### Built With

<a href="https://flutter.dev/" target="_blank"><img src="https://img.icons8.com/color/48/000000/flutter.png" width="45" height="45"/> </a>
<a href="https://git-scm.com/" target="_blank"> <img src="https://img.icons8.com/color/48/000000/git.png"/> </a>
<a href="https://code.visualstudio.com/" target="_blank"> <img src="https://img.icons8.com/color/48/000000/visual-studio-code-2019.png"/> </a>
<a href="https://www.dartpad.dev/?null_safety=true" target="_blank"><img src="https://img.icons8.com/color/48/000000/dart.png" width="45" height="45"/> </a>
<a href="https://github.com/" target="_blank"><img src="https://img.icons8.com/nolan/128/github.png" width="45" height="45"/> </a>


<p align="right">(<a href="#top">back to top</a>)</p>

## Installation

1. Fork the repo to your GitHub account.
2. Clone the repo

```sh
git clone https://github.com/vedantkulkarni/GSOC_Organizations_App.git
```

3. Install Flutter packages

```sh
flutter pub get
```

4. Run the app from lib folder.

```sh
flutter run
```

OR

5. Build apk for the project.

```sh
flutter build apk --split-per-abi --no-sound-null-safety
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
**Don't forget to give the project a star!** Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingGSOCFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingGSOCFeature'`)
4. Push to the Branch (`git push origin feature/AmazingGSOCFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>
