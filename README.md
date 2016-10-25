# Project 2 - *Yelp*

**Yelp** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Search results page
- [x] Table rows should be dynamic height according to the content height.
- [x] Custom cells should have the proper Auto Layout constraints.
- [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [x] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
- [x] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
- [x] The filters table should be organized into sections as in the mock.
- [x] You can use the default UISwitch for on/off states.
- [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
- [x] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- * Search results page
- [x] Infinite scroll for restaurant results.
- * Filter page
- [x] Implement a custom switch instead of the default UISwitch.
- [x] Distance filter should expand as in the real Yelp app
- [x] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).

The following **additional** features are implemented:

- Note: My "additional features" are implementation based features and no UX features. I'm more interested in improving my engineering skills much more than my UX skills.
- [x] Uses RxSwift and RxCocoa observation to simplify some of the asynchronous features.
- [x] Uses Realm to store search filter history.
- [x] Uses Coordinator pattern as presented in [this talk](https://vimeo.com/144116310).
- [x] Storyboardless.
- [x] Cell layout is done with programmatic Auto Layout.
- [x] OAuth2 done without an OAuth2 framework just via connecting RxSwift and Alamofire.

Topics to discuss with peers:
Not directly related to the assigned goals (I've quite a bit of experience with autolayout and basic API calls at this point, so my interests are elsewhere):
   1. General Rx usage. I'm just now learning React and the seemingly limitless list of terms involved is very interesting.
   2. Realm. I've only used Core Data for local storage and I still don't have a clear idea on the tradeoffs between the two for local storage solutions.

## Video Walkthrough

   Here's a walkthrough of implemented user stories:

   <img src='/Yelp.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Notes

   * OAuth2 without some framework designed to assist in the process. I'm not particularly familiar with HTTP terminology so figuring out where to put everything and what to call it was a pain.
   * Figuring out when/where to use Rx. Figuring out why a subscribtion isn't being called. Thinking about different ways to use it instead of older fashioned Objective-C communication such as NotificationCenter/KVO/Delegation.
   * The coordinator pattern. I'm a huge fan of the idea of using coordinators for navigation rather than letting controllers handle something that technically doesn't belong to them. I've been gradually building up the ideas that I want for my `Coordinator` base class and how I want to utilize and implement it's subclasses. I made a lot satisfactory changes (for me, at least) in my implementation for this project that I plan on carrying forward to other projects.


## License

   Copyright [2016] [Nathan Lanza]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.


