# homey
homey assignment

## Requirement

    Use Ruby on Rails to build a project conversation history.

    A user should be able to:

        - leave a comment
        - change the status of the project

    The project conversation history should list comments and changes in status.


## Design Considerations

1. Design database

    1.1 id

        question: should we use an auto-generated incremental ID from the database or build a custom ID generator for sharding?

        my expect: auto-generated incremental ID from the database

    1.2 fk

        question: Which layer should handle foreign keys: the database or the application layer (for sharding)?

        my expect: database

    1.3 comment

        question: what is the comment format: ASCII or Unicode? Can comments contain media such as images, videos, or documents?

        my expect: just simple text

        question: should we restrict the comment length ?

        my expect: yes

    1.4 project status

        question: what field type should be used for project status ?

        my expect: postgresql enum

    1.5 project conversation history

        question: The project conversation history should list comments and status changes. So, do we need to create a model to represent status changes? If yes, then we should create a polymorphic model for both comments and status changes to make displaying the history easier, right?

        my expect: No need to create a status-changes model. We only need to create a comment manually with the status-change as its content. That's all!


2. Application

    2.1 authentication and authorization

            question: should we implement authentication and authorization ?

            my expect: yes, authentication with devise and authorization with pundit

    2.2 changing project status

        question: should we implement state machine logic for changing the project status?

        my expect: not yet

        question: how can we handle race condition when users update the project status ? using distributed lock (redis) or db lock (row-lock select for update)

        my expect: row lock


    2.3 duplication

        question: how to handle duplication cases, such as user click submit multiple times ?

        my expect: we should throttling on frontend and sending timestamp along with the comment to server, on server side we will check. Alternatively, we can use a rate limiter on server side. We are using Rails 7.2 which support an inbuilt API to handle Rate Limiting rules.


        question: how about the case user send duplicate requests for the same comment ?

        my expect: we can use checksum