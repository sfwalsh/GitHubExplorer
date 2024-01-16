# GitHub User Explorer

## User List Screen
- Displays a list of GitHub users.
- Each user row includes:
  - Icon image
  - User name
- Selecting a user row navigates to the User Repository Screen.

## User Repository Screen
- Displays detailed user information at the top of the list.
  - Icon image
  - User name
  - Full name
  - Number of followers
  - Number of followees
- Lists the user's repositories that haven't been forked.
  - Repository name
  - Development language
  - Number of stars
  - Description
- Tapping a repository row opens its URL in a WebView.

# Possible Enhancements and Refinements

- **Enhanced Device Support:**
  - Implement support for both portrait and landscape modes to enhance the user experience on various devices.

- **Global Accessibility:**
  - Incorporate localization support for a broader audience, ensuring a more inclusive and accessible application.

- **Optimized Image Handling:**
  - Introduce image caching mechanisms to optimize performance and reduce load times.

- **Comprehensive User Guidance:**
  - Implement more robust handling of empty states, providing users with informative feedback in various scenarios.

- **Refactoring for Reusability:**
  - Explore opportunities for refactoring to enhance code reusability, particularly between `ListItemView` and `RepositoryListItemView`.

- **Enhanced Error Handling:**
  - Improve the handling and presentation of API errors to provide users with clearer information in case of issues.

- **Search and Refresh Functionality:**
  - Introduce search functionality and the ability to refresh content, enriching the user experience with dynamic interactions.

- **Optimization for Development Workflow:**
  - Optimize development workflows by incorporating mock data layers in Preview Providers for more efficient loading.

- **User-Friendly Number Formatting:**
  - Enhance the formatting of stargazer numbers, possibly through a custom formatter, for improved readability (e.g., rendering 2000 as 2K).

- **Improved UI Consistency:**
  - Enhance the design of `RepositoryListItemView` to address varying heights caused by multiline descriptions, ensuring a more consistent and optimal user experience.

- **Unit Testing Consideration:**
  - Note: Due to time constraints, unit tests have not been implemented in this coding challenge. In a real-world application, a comprehensive suite of unit tests would be essential to ensure code reliability and maintainability.
