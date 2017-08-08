# Chattered (Rails 5 API)

## Specification
General

* The chat is anonymous, no registration or password required
* Users should be able to use a nickname if no one else is using it
* Users should be logged in with same nickname after reopening the browser, if no other user is using it
* The chat has multiple channels
* A nickname can join multiple channels
* A nickname can post messages to channels it's joined
* A nickname can exit channels
* A nickname can create a new channel

API

* A user should be associated with a nickname before being allowed to access the API
* List all users registered
* List all channels
* List all messages in a channel
* List all users that joined a channel
* All requests should limit the number of results returned (pagination)

## Endpoints
| Endpoint      | Method | Functionality                                     |
| --------      | ------ | -------------                                     |
| /login        | POST   | Login (nick online)                               |
| /logout       | DELETE | Logout (nick offline)                             |
| /nicks        | GET    | List all nicks                                    |
| /nicks/:id    | GET    | Get nick data (status, joined and owned channels) |
| /channels     | GET    | List all channels                                 |
| /channels     | POST   | Create a channel                                  |
| /channels/:id | GET    | Get channel data (owner, title, messages)         |
| /channels/:id | POST   | Send message to channel                           |

## Models
#### Nick
* Has a **name** (string / unique)
* Has an access **token**
* Has a **status** (online / offline)
* Has many **Messages**
* Has many owned **Channels**
* Has many joined channels (through **ChannelJoin**)

#### Channel
* Has a **title** (string / unique)
* Has many **Messages**
* Belongs to **Nick** (owned by)
* Has many joined nicks (through **ChannelJoin**)

#### ChannelJoin
* Belongs to **Nick**
* Belongs to **Channel**

#### Message
* Has content (text)
* Has sent date
* Belongs to **Nick**
* Belongs to **Channel**
