## Ruby Visualizer

### Background

Ruby Visualizer is a educational tool to help ruby beginners visualize what their code is doing at each line that is run. Back when we started learning to code, we found tools such as [Python Tutor](http://www.pythontutor.com/) extremely helpful when we were trying to conceptualize code. We wanted to contribute a similar tool geared towards the Ruby community that would be simpler to digest.

### Functionality & MVP

Users will be able to:

- [ ] Input their code
- [ ] See all the local variables of the code at each line
- [ ] Move back and forth between lines of code
- [ ] Receive errors if the code is incorrect and the piece of code that broke it

### Wireframes

![wireframes](docs/wireframe.png)

### Technologies

+ Vue.js / Vuex
+ Ruby on Rails
+ binding_of_caller
+ Tracepoint
+ Webpack
+ Babel
+ Yarn
+ vue-ace-editor
+ HTML / CSS
+ Axios

Ruby Visualizer will be a one page application built with a Vue frontend and a Rails backend. Users will input code into a Vue component, which will then be passed to Rails via Axios request for parsing. The code will be received in a controller and then sent to a code evaluator function to be parsed and formatted. The evaluator will obtain the stack frames for each line of code and store a snapshot of the current variables. The series of snapshots will be put into a JSON object and passed back to the frontend state. The frontend state will handle displaying each snapshot as the user moves through their code.  

#### Challenges

Obtaining stack trace at each line of code.
- We plan to utilize Ruby's builtin TracePoint class to return the stack frame information at each line.

Parsing through the stack trace to obtain relevant data attributes will be returned to our frontend.
- Create a function that uses binding_of_caller to obtain the local and global variables at each stack frame.

Having a input field that receives code and returns in string or JSON format.
- Use vue-ace-editor to provide a text input box for the code to be submitted.

Indicate the line of code that is being evaluated at that point.
- TBD


### Things we accomplished this weekend.
1. Both Bryant and Audrey learned about stack frames and stack history, particularly using Ruby's TracePoint, Kernel methods, and binding_of_caller.
2. Both Bryant and Audrey created a function to parse through an algorithm, applying the methods and concepts about stack frames that they had studied. The function was able to return the desired snapshot of each stack frame. (This took a lot of time!)
3. Both Bryant and Audrey learned the basics of Vue and deployed a basic web application.
4. Both Bryant and Audrey learned how to setup the Ace text editor to display ruby and update themes.


### Group Members & Work Breakdown

Our group consists of two members, Audrey Mefford and Bryant Luong.

Audrey's primary responsibilities will be:

- Create parsing function in backend for JSON code object
- Create evaluator algorithm to return snapshots of stack frames
- Create display component with Vue
- Implement Ace Text Editor on Vue component
- Handle Axios responses from backend
- Write the repo's production README


Bryant's primary responsibilities will be:

- Create parsing function in backend for JSON code object
- Create evaluator algorithm to return snapshots of stack frames
- Create display component with Vue
- Create header and footer components with Vue
- Handle Axios requests from frontend

### Implementation Timeline

**Day 1**: Setup basic framework for application. Create a simple version of evaluator algorithm.
- Set up rails to receive json object. (Bryant)
- Set up Vue to display a simple webpage. (Audrey)
- Create algorithm to obtain snapshots of stack frames. (Both)

**Day 2**: Setup Ace editor to display text editor on Vue Component.

- Setup Ace Editor to render on our webpage. (Bryant)
- Format information submitted by the Ace Editor. (Audrey)
- Create actions on Vue to pass an Axios request to backend. (Audrey)

**Day 3**: Finish the evaluator algorithm and backend to parse information and return JSON object with data desired.

- Optimize and test evaluator algorithm with the working view component. (Audrey)
- Render data received from backend on the webpage. (Bryant)

**Day 4**: Visualize the data received into an appealing and understandable format.

- Create a view component for the display and style. (Bryant)
- Create indicator for the text editor to show the line being displayed. (Audrey)

**Day 5**: Create header, footers, and an example Modal.

- Create Header/Footer. (Bryant)
- Create example modal that will demonstrate how the site works. (Audrey)
- Production README and grab screenshots/GIFS. (Bryant)

## Additional Features
- Add a print log, that will output print statement in code
- Add classes, to visually display classname and global variables
