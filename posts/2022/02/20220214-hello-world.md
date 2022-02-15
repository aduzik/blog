This is the blog I've been meaning to start for, oh, a decade. You know how you're tooling along, doing your job, and then you hit some sort of bizzaro error, or edge case you don't know how to resolve, so you go to the [universal software development reference manual](https://www.google.com) and start typing words until something comes up that makes sense? Well, it's my life's ambition to be the thing that comes up in a Google search just once.

![Life non-goals](https://imgs.xkcd.com/comics/wisdom_of_the_ancients.png)

Well, in any case, here's this blog.

# Let's talk DevOps

I thought a fun way to start would be to talk about how this very blog came into existence. Let me start by saying that this is far from the best way to set up a blog. You should probably just go to wordpress.com and create an account. But I decided to go a different, more unnecessarily complicated route because of reasons.

DevOps, as you probably know, brings together both development and operation of, typically, an application into a single, unified workflow. You can read about this from much smarter people, but the important principles I want to talk about are:

- **Everything is code.** Your application, plus all the necessary tooling and configuration to deploy it, are all stored in a repo somewhere.
- **Everything is automated.** Using the CI platform of your choice, you should be able to deploy/upgrade a working version of your application with little to no unnecessary human intervention.

Now, I'm just setting up a Wordpress blog here, so I'm not going to write code, really. This is going to be ops-heavy, or "devOPS" if you like. My goals are:

- To create the environment for the Wordpress blog using a CI pipeline
- To deploy a working application into the pipeline

# The environment

In my professional life, I've mostly used Microsoft Azure. I think Azure is a terrific platform. And, for the purposes of this blog, we can run this sucker totally free. Here's how it'll look when we're done:

1. Wordpress running in a Docker container in Azure App Service. Why Docker? Because if you can run one containerized application you can run them all.
2. MariaDB running in Azure Database for MariaDB. Why go through the trouble of setting up a database server when Azure can do it for you?

Now listen, I know that deploying a Wordpress site to Azure App Service is literally a single click operation, but humor me here. How we go about producing this is really the focus of this post.

# How do we go about doing this, anyway?

Let's talk about the bits and pieces we'll be using to make this all work.

## GitHub

Your code's gotta live somewhere, and GitHub is popular for a reason. I've posted the code for this project on GitHub, so you can [follow along](https://github.com/aduzik/blog) if you like.

## Azure Pipelines

GitHub has the excellent GitHub Actions service for running pipelines, but I'm using Azure DevOps Pipelines because, well, it's what I know. You can create an Azure DevOps organization with Basic accounts for up to five users completely free. For playing around purposes and small teams, it's incredible.

Like GitHub actions, your Azure Pipelines live in a YAML file that you can store in your repo right next to your application code. Dev and ops, all in one place. Azure Pipelines acts as a sort of orchestrator that runs your pipeline and keeps track of its state, but the actual work is delegated to _agents_. Agents are any machine that runs, well the pipeline agent. You connect it to your DevOps account and it sits around waiting to be assigned work. There are agents for every major platform, so they can be used to run build and deployment tasks for really any platform you can think of. Microsoft also hosts their own agents, and you get a certain allotment of time even in a free account.

## Bicep

There are a few ways you can deploy resources in Azure. You could write a shell script or PowerShell and create them by hand, but you really don't need to. The Azure Resource Manager exists specifically for this purpose. ARM is a service that takes JSON files and turns them into Azure resources. You tell it what you want, it goes off and makes it for you. It's pretty slick.

But, an ARM template by itself is essentially just a big JSON file, and the files can get a little bit ugly. To solve this, they created a DSL called Bicep that's much easier to work with greatly improves the readability of Azure resource deployments. Of course, it has great support in VS Code, so getting up and running is quite easy, and there's even a great [learning path on docs.microsoft.com](https://docs.microsoft.com/en-us/learn/paths/bicep-azure-pipelines/) that will take you on a grand tour of the entire thing. It's well worth your time.

# Bringing it all together

So I think that covers all the basics. This is a blog, it's running on Azure App Service with a Azure SQL for MariaDB database. It's deployed from Azure Pipelines, using a Bicep file to build the app resources. The next post will cover how this actually works.
