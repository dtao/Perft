Perft!
======

The goal of this project is to be like CI for *performance*. That is, every time you check in code to a project, you can immediately see the performance impact that change has on the performance of everything you've chosen to measure.

Ideally, this can integrate with testing frameworks; e.g. RSpec, to bring the cost of adoption to an absolute minimum.

I'm starting off w/ Ruby just because it's easiest. But the eventual plan is to have a web service that can accept data from any source, in any programming language. (Actually, I'm doing the web service part *first*, to be followed up by a Ruby gem. Then probably a JavaScript library, and then onto Java, .NET, etc. if the project gains traction and/or I don't lose steam.)

High-level plan (this will change)
----------------------------------

### Perft

The web service. Will figure out some standard API to submit performance test results to the service.

The front end will have all sorts of awesome charts and graphs.

### perft-ruby

A Ruby gem to integrate w/ RSpec (?) and shoot up results to the web service. I'm thinking:

- You create a 'project' and get some API key for a single machine
- You put a config file (like ".perft-config" or something) on the machine that will submit performance test results (this will *probably* not be in version control since you'll only want results from one or a finite set of machines, and also since it will have your API key/secret/whatever)
- For every commit, your designated "Perft" machine will run all automated performance tests and upload the results to the server

### &c.

From there, it's off to the races. Node module, Java library (JPerft?), C# library (NPerft?), and so on and so forth.
