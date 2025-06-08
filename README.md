# Blockchain-Based Hospitality Guest Experience Management

A comprehensive blockchain solution for managing hospitality guest experiences using Clarity smart contracts on the Stacks blockchain.

## Overview

This system provides a decentralized platform for hospitality providers to manage guest experiences, collect feedback, and ensure quality standards. The solution consists of five interconnected smart contracts that work together to create a transparent and efficient hospitality management ecosystem.

## Smart Contracts

### 1. Hotel Verification Contract (\`hotel-verification.clar\`)
- **Purpose**: Validates and manages hospitality providers
- **Key Features**:
    - Hotel registration system
    - Verification process by contract owner
    - Hotel information storage and retrieval
    - Verification status checking

### 2. Guest Profile Contract (\`guest-profile.clar\`)
- **Purpose**: Manages guest preferences and booking history
- **Key Features**:
    - Guest profile creation and updates
    - Preference management
    - Booking history tracking
    - Loyalty points system

### 3. Service Customization Contract (\`service-customization.clar\`)
- **Purpose**: Customizes hospitality services based on guest preferences
- **Key Features**:
    - Service preference customization
    - Hotel service catalog management
    - Room, dining, and amenity preferences
    - Special request handling

### 4. Feedback Collection Contract (\`feedback-collection.clar\`)
- **Purpose**: Collects and manages guest experience feedback
- **Key Features**:
    - Multi-dimensional rating system (overall, service, cleanliness, amenities)
    - Comment collection
    - Hotel rating aggregation
    - Duplicate submission prevention

### 5. Quality Assurance Contract (\`quality-assurance.clar\`)
- **Purpose**: Ensures hospitality service quality through monitoring
- **Key Features**:
    - Quality standards setting
    - Incident reporting system
    - Compliance score tracking
    - Hotel certification management

## Architecture

\`\`\`
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Hotel           │    │ Guest Profile   │    │ Service         │
│ Verification    │    │ Management      │    │ Customization   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
│                       │                       │
└───────────────────────┼───────────────────────┘
│
┌─────────────────────────────────────────────┐
│            Core System                      │
└─────────────────────────────────────────────┘
│
┌───────────────────────┼───────────────────────┐
│                       │                       │
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Feedback        │    │ Quality         │    │ Blockchain      │
│ Collection      │    │ Assurance       │    │ Infrastructure  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
\`\`\`

## Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd hospitality-blockchain
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Deploy contracts to testnet:
   \`\`\`bash
   clarinet deploy --testnet
   \`\`\`

### Testing

Run the test suite using Vitest:

\`\`\`bash
npm test
\`\`\`

Individual test files:
\`\`\`bash
npm test hotel-verification.test.js
npm test guest-profile.test.js
npm test feedback-collection.test.js
npm test quality-assurance.test.js
\`\`\`

## Usage Examples

### Hotel Registration
\`\`\`clarity
(contract-call? .hotel-verification register-hotel "Grand Hotel" "New York, NY")
\`\`\`

### Guest Profile Creation
\`\`\`clarity
(contract-call? .guest-profile update-profile "John Doe" "Non-smoking, late checkout")
\`\`\`

### Service Customization
\`\`\`clarity
(contract-call? .service-customization customize-services
u1 "Ocean view room" "Vegetarian meals" "Spa access" "Early check-in")
\`\`\`

### Feedback Submission
\`\`\`clarity
(contract-call? .feedback-collection submit-feedback
u1 u1 u4 u5 u4 u3 "Excellent service and clean facilities")
\`\`\`

## Data Models

### Hotel Data Structure
- \`hotel-id\`: Unique identifier
- \`owner\`: Hotel owner principal
- \`name\`: Hotel name
- \`location\`: Hotel location
- \`verified\`: Verification status
- \`registration-block\`: Registration block height

### Guest Profile Structure
- \`guest\`: Guest principal
- \`name\`: Guest name
- \`preferences\`: Service preferences
- \`loyalty-points\`: Accumulated points
- \`total-stays\`: Number of stays
- \`created-block\`: Profile creation block

### Feedback Structure
- \`overall-rating\`: Overall experience rating (1-5)
- \`service-rating\`: Service quality rating (1-5)
- \`cleanliness-rating\`: Cleanliness rating (1-5)
- \`amenities-rating\`: Amenities rating (1-5)
- \`comments\`: Text feedback
- \`submitted-block\`: Submission block height

## Security Features

- **Access Control**: Owner-only functions for critical operations
- **Input Validation**: Rating bounds checking and data validation
- **Duplicate Prevention**: Prevents duplicate feedback submissions
- **Immutable Records**: Blockchain-based permanent record keeping

## Error Codes

### Hotel Verification
- \`u100\`: Owner only error
- \`u101\`: Already registered
- \`u102\`: Not found
- \`u103\`: Not verified

### Guest Profile
- \`u200\`: Not found
- \`u201\`: Unauthorized

### Service Customization
- \`u300\`: Not found
- \`u301\`: Unauthorized
- \`u302\`: Invalid service

### Feedback Collection
- \`u400\`: Not found
- \`u401\`: Invalid rating
- \`u402\`: Already submitted

### Quality Assurance
- \`u500\`: Owner only
- \`u501\`: Not found
- \`u502\`: Invalid score

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue in the GitHub repository.
\`\`\`

Finally, let's create the PR details file:
