# Scripts_for_AD
Install and configure the Active Directory directory service.

Learn the methods and mechanisms for installing and configuring the Active Directory directory service.

1. To invent and describe the structure of some company (without binding to computer software).
2. Develop a logical structure of Active Directory that meets the company's structure.
3. Perform the installation and configuration of Active Directory in accordance with the developed structure.
4. Create the following administrative user groups in Active Directory: Account Managers, Help Desk, Resource Admins, Genereal Admins.
5. Configure permissions for the created user groups:
    Account Managers can only create accounts for new employees and delete them if necessary.
    Help Desk can only unlock user accounts in case they are blocked when the password is not entered correctly.
    Resource Admins should control access to the information resources of the organization.
    General Admins must have full access and control the work of the administrators of the lower levels.
    6. Create test users in each of the groups.
7. Verify that the privileges are configured correctly by attempting to perform the appropriate actions on the user names of the various groups.
8. Create a file server. The file server must have folders for each computer and each user in the organization. When a user logs on to a certain computer, two shared resources must be mounted, corresponding to the computer folder and the user's folder on the file server.
9. Create a toolkit that helps administrators work: a script to search for users who will soon expire the password, and a script to unlock all user accounts in the specified organizational unit.
