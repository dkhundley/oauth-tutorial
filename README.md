![](assets/oauth-tutorial-banner.png)
# OAuth 2.0 Tutorial
Hi all! I'm a machine learning engineer, and while my expertise is in AI/ML, security is always top of mind. When AI agents and agentic tools, many platforms are now leveraging **OAuth** as a security measure. I have personally found understanding this topic to be very confusing, even more so than many AI/ML concepts. In conjunction with a YouTube stream, I hope to shed light on this topic, both at an intuitive, conceptual level and applying our knowledge with code. In terms of the code, we will be demonstrating how to leverage OAuth with **Amazon Web Services (AWS) Cognito** as well as **Microsoft Azure Entra ID**.

Please note: This repo and content is being published in February 2026. I transparently do not have any intention of maintaining this repo over time, so it's possible that as time progresses, things shared in this repo will also change.



## Start Here
To help you understand how to get the most value out of this tutorial, this section here lays out how I intend for a learner to learn these concepts.

1. **Understand authentication vs. authorization**: At its foundation, OAuth is conceptually a framework that facilitates authentication and authorization. It is not uncommon for people to confuse these together, especially since each concept plays a strong role with the other. In this same README you are reading right now, you will find a section called "Authentication vs. Authorization" that briefly discusses these concepts.
2. **Grounding our understanding of authentication vs. authorization with an analogy**: Because these concepts can be confusing to understand, we'll ground our knowledge using an analogy: staying at a hotel. Please navigate to the "Hotel Analogy" section in this README to learn more.
3. **Understanding OAuth 2.0's history**: You will find that OAuth 2.0 adopts some specific terminology, which I personally found confusing until I understood the history behind OAuth 2.0. In this same README, you can read a brief history about how OAuth 2.0 came to be.
4. **Understanding OAuth 2.0's discovery endpoint and JWT standard claims**: There are two respective sections in this README that talk about the OAuth 2.0's discovery endpoint and JWT standard claims. Please review these as it will help to give you a more conceptual understanding of how OAuth 2.0 works.
5. **Setting up OAuth 2.0 with AWS Cognito**: If you would like to continue setting up OAuth 2.0 with AWS Cognito, please see the respective section in this README on the steps for doing that. I have also included Terraform for building this same infrastructure within `/terraform/aws/` of this repo.
6. **Setting up OAuth 2.0 with Azure Entra ID**: If you would like to continue setting up OAuth 2.0 with Azure Entra ID, please see the respective section in this README on the steps for doing that. I have also included Terraform for building this same infrastructure within `/terraform/azure/` of this repo.



## Authentication vs. Authorization
Before jumping into anything directly related to OAuth, it's first important to understand the concepts of **authentication** and **authorization**. These two concepts are similar and are connected, but they are distinct concepts that, as we'll learn in the history section, more or less began on parallel paths.

First, let's cover authentication. Authentication is the concept of verifying identity. Naturally, this is important because you don't want just anybody accessing your application! You want to be sure that only the appropriate—or authenticated—users have the access they need.

Now, let's contrast this with authorization. Authorization is focused on the actions you are permitted to do. So if your application accepts reads and writes, you may have some calling clients that may just need access to read or just access to write. Or perhaps both!

I hope you can gain an appreciation of why you likely need both. One thing I want to call out: API keys. If you've interacted with something like the OpenAI API, you've likely had to pass in an API key. An API key is NOT OAuth, and the key here is the "lack" of authorization. Arguably, API keys are less secure than OAuth, but that doesn't mean the API key pattern is an unsecure pattern. The usage of an API key places an emphasis authentication and de-emphasizes the importance of authorization. And when you think about something like the OpenAI API, this makes sense: OpenAI doesn't have fine grained on access on who is allowed to do what.



## Hotel Analogy
Now that we understand the difference between authentication and authorization, let's ground our knowledge with a hotel analogy. At the time I am writing this, I personally just went with my family to Great Wolf Lodge up in the Wisconsin Dells. (A fun family time!) If you're not familiar with Great Wolf Lodge, it is a hotel that also has a conjoined indoor water park. Other that having the water park, Great Wolf Lodge is more or less a standard hotel.

As you probably know, most modern hotels use a keycard when you want to get around the hotel. Generally speaking, your hotel keycard can get you into...

- Your hotel room (and ONLY your hotel room)
- The hotel fitness center
- The hotel pool (or indoor water park, in the case of Great Wolf Lodge)
- Maybe a VIP lounge

This keycard is ONLY usable during the duration of your stay. This is great for the hotel since if you checkout and you mistakenly leave with the hotel keycard, the worst the hotel is out is a little piece of plastic. It's not as if you could return the following week and use that same keycard to get back into all the things listed above.

Now, let's focus on what authentication and authorization means here.

When you first come to check into the hotel, you will need to go to the front desk. The front desk is going to likely ask for your driver's license / identification. **This is authentication in action.** Remember, authentication about verifying your identity. In this hotel analogy, the hotel clerk is a human individual verifying your identity.

(Quick side note: I'm well aware that you can bypass the front desk if you check in through a smartphone app. Just roll with me here, folks. 😂)

As you check in, the hotel clerk will give you a keycard that has access to some or all of the things mentioned above. Focus on that phrase **"some or all"**. You will only have access to only what the hotel clerk gives you access to per what you've reserved. Naturally you'll have access to your hotel room, but the others are a mixed bag. If there's a VIP lounge, you're only going to have access if you pay for that benefit. When it comes to pools and fitness centers, your keycard will only work during the hours that those facilities are open. (Assuming that they are not open 24/7.) **This is authorization in action.** You and the next guest will have the same "authentication" experience of interacting with the hotel desk clerk, but your experiences WILL differ in terms of authorization. It will differ naturally because you and another random guest are definitely not sharing the same hotel room, and it may differ further based on the amenities each of you respectively pay for.



## The History Behind OAuth 2.0
When learning about different things such as Bedrock AgentCore, I found some terminology associated to OAuth 2.0 that I found confusing, so I dug through the history of OAuth 2.0 to understand how some of those terms came to be. In this section, we'll give a birds eye view into how OAuth 2.0 came to be.

- Earliest History (Pre-2005)
    - People began recognizing that identity security was becoming a problem. Many did not like having to give any ol website your personal information as you can't be sure what that website will do with the information.
    - The earliest forms of identity started to solve the problem but still experienced the issue of giving a random website sensitive information. For example, in its earliest days, you could use Gmail as an identity platform, but even doing that, you still had to give the random website your personal Gmail password. On top of that, there was no way to revoke the website's identity access later down the road.
- OpenID (2005-2011)
    - Stared by Brad Fitzpatrick (creator of Live Journal), the intention behind the creation of OpenID was to create a decentralized authority that no single corporation could control in order to specifically solve the problem of authentication. (Think of it similarly to the proposed government digital IDs that are now being floated, except that OpenID naturally isn't governed by any official national government.)
    - OpenID gained traction with the formation of the OpenID foundation. It gained traction with big supporters like Google, Yahoo, and Microsoft.
    - OpenID proposed maintaining your identity as a URL. For example, your OpenID may look like `https://david.example.com`.
    - The earliest implementation of OpenID struggled for several reasons, including:
        - Being a terrible user experience (UX) for the layperson
        - Increasing the potential for phishing schemes
        - Having too many bad actors due to too much decentralization
        - Being too difficult for many developers to work with
- OAuth 1.0 (2007-2010)
    - This was originally introduced to solve the problem of authorization.
    - Key players involved in the original creation of OAuth 1.0 included Google, Twitter, and Flickr.
    - Developers found it overly complicated to work with.
- OAuth 2.0 (2012)
    - This was a big redesign of OAuth 1.0 to make it much simpler for developers to work with.
    - The original 2.0 release helped to make the experience of solving authorization, but it did not necessarily make authentication any easier.
- The Merge (2014)
    - The OpenID Foundation realizes that essentially OAuth 2.0 had won the "protocol war", so instead of trying to compete, they chose to merge with OAuth 2.0 in what is now referred to as **OpenID Connect (OIDC)**.
    - OIDC added identity tokens manifesting as **JSON web tokens (JWTs)**. It also introduced standards around discovery endpoints and standard claims associated to the identity JWTs.


## OAuth 2.0's Discovery Endpoint
OAuth's discovery endpoint provides standards around how clients should interact with an OAuth issuing body. These include the following:

- Every issuer must expose an endpoint that follows this same URL format: `https://your-issuer-domain/.well-known/openid-configuration`
- The discovery endpoint returns JSON describing the following elements:
    - `authorization_endpoint`
    - `token_endpoint`
    - `jwks_uri`
    - `userinfo_endpoint`
    - The supported scopes
    - The supported response types
    - The supported algorithms
- When you configure OAuth 2.0 with issuers like AWS Cognito or Azure's Entra ID, under the hood your app is...
    - Interacts with the Discovery URL to fetch the discovery JSON
    - Reads the `jwks_uri`
    - Validates ID token signatures
    - Extracts standard claims



## OAuth 2.0 Standard Claims
When a client application interacts with an issuer, we receive back an identity token in the form of JWT. As part of this JWT, there are a number of standard claims associated to the JWT. You can certainly add more claims than the standard ones, but the core ID token claims inclue the following:

- `iss`: Stands for "issuer" and defines who issued the token
- `sub`: Stands for "subject" and represents the unique user ID
- `aud`: Stands for "audience" and represents who the token is intended for
- `exp`: Stands for "expiration time" and naturally represents when a token expires
- `iat`: Stands for "Issued at time" and represents when a token was originally issued



## AWS Cognito
In this section, we'll walk through the general steps of how you can set up OAuth 2.0 with **AWS Cognito**. Because user interfaces constantly change, I'm not going to provide any screenshots and instead will provide a text-based guide. I would also encourage you watch [my YouTube livestream here](https://www.youtube.com/live/kizaSAQ-7vg?si=i1qwp9k200KAooLY) if you want to see me go through these steps in video form. I would also encourage you reference [AWS's official Cognito documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools.html) for additional guidance.



## Azure Entra ID
In this section, we'll walk through the general steps of how you can set up OAuth 2.0 with **Azure Entra ID**. Because user interfaces constantly change, I'm not going to provide any screenshots and instead will provide a text-based guide. I would also encourage you watch [my YouTube livestream here](https://www.youtube.com/live/kizaSAQ-7vg?si=i1qwp9k200KAooLY) if you want to see me go through these steps in video form. I would also encourage you reference [Azure's official Entra ID documentation](https://learn.microsoft.com/en-us/entra/identity/) for additional guidance.