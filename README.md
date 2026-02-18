# OAuth Tutorial
Hi all! I'm a machine learning engineer, and while my expertise is in AI/ML, security is always top of mind. When AI agents and agentic tools, many platforms are now leveraging **OAuth** as a security measure. I have personally found understanding this topic to be very confusing, even more so than many AI/ML concepts. In conjunction with a YouTube stream, I hope to shed light on this topic, both at an intuitive, conceptual level and applying our knowledge with code. In terms of the code, we will be demonstrating how to leverage OAuth with **Amazon Web Services (AWS) Cognito** as well as **Microsoft Azure Entra ID**.

Please note: This repo and content is being published in February 2026. I transparently do not have any intention of maintaining this repo over time, so it's possible that as time progresses, things shared in this repo will also change.



## Start Here
To help you understand how to get the most value out of this tutorial, this section here lays out how I intend for a learner to learn these concepts.

1. **Understand authentication vs. authorization**: At its foundation, OAuth is conceptually a framework that facilitates authentication and authorization. It is not uncommon for people to confuse these together, especially since each concept plays a strong role with the other. In this same README you are reading right now, you will find a section called "Authentication vs. Authorization" that briefly discusses these concepts.
2. **Grounding our understanding of authentication vs. authorization with an analogy**: Because these concepts can be confusing to understand, we'll ground our knowledge using an analogy: staying at a hotel. Please navigate to the "Hotel Analogy" section in this README to learn more.



## Authentication vs. Authorization
Before jumping into anything directly related to OAuth, it's first important to understand the concepts of **authentication** and **authorization**. These two concepts are similar and are connected, but they are distinct concepts that, as we'll learn in the history section, more or less began on parallel paths.

First, let's cover authentication. Authentication is the concept of verifying identity. Naturally, this is important because you don't want just anybody accessing your application! You want to be sure that only the appropriate—or authenticated—users have the access they need.

Now, let's contrast this with authorization. Authorization is focused on the actions you are permitted to do. So if your application accepts reads and writes, you may have some calling clients that may just need access to read or just access to write. Or perhaps both!

I hope you can gain an appreciation of why you likely need both. One thing I want to call out: API keys. If you've interacted with something like the OpenAI API, you've likely had to pass in an API key. An API key is NOT OAuth, and the key here is the "lack" of authorization. Arguably, API keys are less secure than OAuth, but that doesn't mean the API key pattern is an unsecure pattern. The usage of an API key places an emphasis authentication and de-emphasizes the importance of authorization. And when you think about something like the OpenAI API, this makes sense: OpenAI doesn't have fine grained on access on who is allowed to do what.