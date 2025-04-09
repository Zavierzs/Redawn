# Redawn

## Abstract

Redawn is a Flutter-based application designed to address a modern challenge that is mostly ignored by the community through our innovative and creative solutions. By leveraging Google technologies, the app provides a seamless user experience while promoting sustainable development goals (SDGs), focusing on the good health and well-being of the users. Using flutter made us able to bring our creativity into the user interface. We included the element of pets to cherish the users more. The project integrates Firebase for backend services, ensuring scalability, security, and real-time data synchronization.

---

## Introduction

### Problem Statement

According to Malaysia’s National Health and Morbidity Survey, 29.2% of Malaysians aged 16 and above suffer from mental health issues. Cases have doubled over the past 10 years, with young adults (16-24 years) being the most affected group. Mental illness is projected to become the second-largest health issue in Malaysia after heart disease. There are 48 Ministry of Health hospitals and 4 mental institutions providing psychiatric services, and 671 health clinics as well as 20 Community Mental Health Centres of to cater for the community with mental health problems. However, patients are instinctively reluctant to look for help.

Key challenges include:

- **Lack of awareness and ignorance**: Many individuals are unaware of mental health issues or how to seek help.
- **Stigma and cultural beliefs**: Mental health is often viewed negatively, leading to social discrimination and reluctance to seek support.

### Target Users

Redawn is designed for the following groups:

- Young adults and university students (16-30 years old)
- Working adults and professionals (25-45 years old)
- Individuals experiencing financial stress
- Mental health advocates and therapists
- Employees and HR departments
- New parents and caregivers (struggling with postpartum depression, parenting stress, sleep deprivation)
- Elderly and retired individuals (50+ years old, dealing with loneliness, health anxiety, or loss of purpose)
- People recovering from mental health issues

### Sustainable Development Goals (SDGs)

Redawn aligns with **SDG 3: Good Health and Well-Being**, which aims to ensure healthy lives and promote well-being for all at all ages. By addressing mental health challenges, Redawn contributes to creating a healthier and more inclusive society, helping us to identify the mental issue earlier and lower the suicide rate. We have also targetted **SDG 10: Reduced Inequality**, by ensuring all individuals have access to mental health services, support, and opportunities for social inclusion.

---

## Implementation

### System Architecture

The system architecture of Redawn is designed to ensure scalability, reliability, and efficiency. It consists of the following components:

1. **Frontend**: Developed with Flutter, it offers a cross-platform web, iOS, and Android user experience.
2. **Backend**: Powered by Firebase, it offers real-time database, authentication, and cloud storage.
3. **Integration**: The services of Firebase and Google Sign-In are seamlessly combined to improve security and user experience.

### Products and Platforms Implemented (Google Technologies)

Redawn utilizes the following Google technologies:

- **Firebase Authentication**: To secure user's sign up and login, including email/password registration and Google Sign-In.
- **Google Sign-In**: Simplifies the authentication process by allowing users to log in with their Google accounts.
- **Firebase Firestore**: A real-time NoSQL database for storing and retrieving user data.
- **Firebase Cloud Messaging**: Sends notifications to users.
- **Flutter**: A Google-backed framework for building natively compiled applications for mobile, web, and desktop from a single codebase.

### Expanding the System Architecture

While Redawn already incorporates a modern stack, several enhancements can be made to further strengthen its architecture:

- **Real-Time Analytics**:  
  Integrate Firebase Analytics to gather usage metrics and insights into user engagement. This data could guide further development, focusing on features that resonate most with users.

- **Offline-First Approach**:  
  Continue leveraging Firestore’s offline capabilities. Users can draft journal entries, track progress, or read mental health tips even without an internet connection, ensuring uninterrupted guidance.

- **Modular Code Organization**:  
  Further break down large Flutter widgets or critical business logic into smaller modules. This modularity not only maintains clean code but also simplifies future updates (e.g., new mental health resources or interactive exercises).

- **Security and Compliance**:  
  Consider adding more granular Firebase security rules and encryption to ensure compliance with privacy standards for storing sensitive mental health data.

By combining these technologies, Redawn delivers a robust and scalable solution that addresses mental health challenges while contributing to global sustainability efforts.

## Feedback

In response to some of the users' feedback, several minor features and improvements have been implemented to enhance the overall experience of Redawn. We ensure that every piece of feedback was addressed effectively. Key updates include:

- **UI/UX Enhancements**:

  - Refined navigation and layout components to improve usability.
  - Minor adjustments to widget spacing and color schemes based on user suggestions.

- **Security Updates**:

  - Updated Firebase security rules to meet stricter compliance and better data protection standards.
  - Introduced additional encryption measures for sensitive information.

- **Feature Adjustments**:
  - Integrated additional error messages and feedback prompts to help users understand and resolve common issues.
  - Implemented subtle animations and transitions for a smoother in-app experience.

## Scalability

Redawn is designed with scalability in mind, as it is just a prototype for now. To ensure it can grow and adapt to meet the needs of a larger audience, the following steps outline how the current solution can expand:

- **Future Steps**:

  - Expand the platform to support multiple languages, making it accessible to a global audience.
  - Partner with mental health organizations and professionals to provide verified resources and services.
  - Develop additional features, such as community forums and peer support groups, to foster a sense of belonging and shared experiences.

- **Adaptability for Larger Audiences**:
  - The use of Firebase ensures that the backend can handle increased traffic and data storage requirements with minimal changes.
  - Flutter's cross-platform capabilities allow for seamless deployment across Android, iOS, and web, ensuring accessibility for a diverse user base.
  - Firebase Cloud Messaging enables efficient communication with users, even as the user base grows.
  - Modular architecture allows for the easy addition of new features and services without disrupting existing functionality.

By focusing on these strategies, Redawn is well-positioned to scale effectively while maintaining a high-quality user experience and addressing mental health challenges on a broader scale.
