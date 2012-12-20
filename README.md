#[SubscriberSearch-rub]
=================

SubscriberSearch-rub is an example application which illustrates how to create a Hub Exchange application utilizing Single Sign-on (SSO) for ExactTarget's Interactive Marketing Hub.

The full application allows the user to search their ExactTarget subscriber list and update the subscriber status of individual subscribers. 

#Tags
----------
This application was built in steps and they are [tagged](https://github.com/ExactTarget/SubscriberSearch-rub/tags)  so that you can get the final application or just specific code.

Step1 - Created the basic app and implemented the JWT for display in Interactive Marketing Hub


#Requirements
----------
* Access to App Center on http://code.exacttarget.com
* Server running Ruby version 1.9.3 (it may still work in previous version, but has not been tested)


#Quick start
-----------

1. Clone the repo onto your server 
2. Create a new Hub Exchange application in [App Center](http://code.exacttarget.com/appcenter) (requires login) naming it what you want and publishing it once complete. 
3. For the Login URL, put the path to "/login".  For the Home URL, put the path to "/".  For the Logout URL, put the path for "/logout".
5. Open app.rb and input the Application Secret, ClientID, and Client Secret provided by App Center
6. Go to [ExactTarget IMH](https://imh.exacttarget.com) and login to your ExactTarget account. Your application created in App Center should be in the IMH menu. Select it and accept any mixed security warnings if you receive them.

For more information about setting up an application in App Center, please see [App Center Overview](http://code.exacttarget.com/devcenter/getting-started/app-center-overview) and [Registering App](http://code.exacttarget.com/devcenter/devcenter/getting-started/app-center-overview/registering-app).

#Authors
-----------
Kelly Andrews

* http://github.com/kejandre

#Copyright and license
-----------

Copyright (c) 2012 ExactTarget

Licensed under the MIT License (the "License"); you may not use this work except in compliance with the License. You may obtain a copy of the License in the COPYING file.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.