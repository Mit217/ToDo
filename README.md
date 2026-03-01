# Flutter Firebase ToDo Web App
A cloud-based task management web application built using **Flutter Web** and **Firebase**, supporting real-time synchronization, secure authentication, and responsive UI.

## Overview
This project demonstrates full-stack development using Flutter as the frontend and Firebase as the Backend-as-a-Service (BaaS). The application allows users to manage personal tasks with persistent cloud storage and secure login.

## Key Features
* User authentication using Firebase Authentication (Email/Password)
* Real-time task storage and synchronization using Cloud Firestore
* Create, update, complete, and delete tasks
* Task completion with visual feedback (fade and reorder)
* Per-user data isolation using UID-based access control
* Responsive web interface
* Deployed using Firebase Hosting

## Tech Stack
**Frontend:**
Flutter Web, Dart

**Backend:**
Firebase Authentication
Cloud Firestore
Firebase Hosting

## Architecture
Flutter Web App
      │
      ▼
Firebase Authentication
      │
      ▼
Cloud Firestore Database
      │
      ▼
Firebase Hosting

## Database Schema

Collection: `tasks`
Fields:
* `task` : String
* `uid` : String
* `createdAt` : Timestamp
* `isDone` : Boolean

## Security
Firestore rules enforce user-specific access:
allow read, write: if request.auth != null && request.auth.uid == resource.data.uid;

## Deployment
The application is deployed using Firebase Hosting.

Production URL:
(https://todo-90a1d.web.app/)

## Author
Mithra Sreejith
GitHub: https://github.com/Mit217
