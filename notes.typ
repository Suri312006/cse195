
#import "@preview/cheq:0.2.2": checklist

#show: checklist
#show link: underline
#set heading(numbering: "1.a.1. ")

= Senior Thesis Big Ideas
Whats needed to integrate information control flow into Twizzler

= Papers to read

- [ ] #link("https://pdos.csail.mit.edu/papers/flume-sosp07.pdf")[Flume]

- [ ] #link("https://owenarden.github.io/home/papers/flam_csf15.pdf")[Flow Limited Authorization]
  - Dont worry too much about the math

- [ ] #link("https://dl.acm.org/doi/abs/10.1145/3498688")[Isolation Without Taxation]
  - wasm / software fault isolation

- [ ] #link("https://dl.acm.org/doi/10.1145/3649817")[Static IFC in Rust]


- [x] #link("https://dl.acm.org/doi/10.1145/2166956.2166961")[Capabilities for Information Flow]
  - #strike[lowkey probably really important]

- [ ] #link("https://ieeexplore.ieee.org/document/7536373")[On Access Control, Capabilites, Their Equivalence, and Confused Deputy attacks]

- [ ] #link("https://research.google/pubs/macaroons-cookies-with-contextual-caveats-for-decentralized-authorization-in-the-cloud/")[Macaroons]


= Questions

// = Notes

= Capabilities for Information Flow

- a transformation that takes any source program in a simple language, and outupts a
secure program in a language with capabilities 
  - #highlight(fill: aqua)[static] instead of runtime solution?
  - 

// terms that were defined in the paper
== Index
+ Secure Composition 

   Its a challenge to integrate unsecure third-party code with secure code. Blind
   integration would have security hazards so something else must be done

+ Integration vs Seperation

   Yahoo, Facebook, and Google basically take a subset of javascript and allow that
   to be integrated with their secure systems. They perform static analysis on the
   JS code, and rewrite sensitive parts and insert dynamic checks for security.

+ Capability Enforcement 

  Google's model uses _object-capability model_ where capabilites are unique, uncloneable
  references for accessing critical resources. 

  "In capability systems, preventing data to flow is harder than preventing capabilities from being
  propogated, even if we consider overt communication channels"

  #highlight(fill: yellow)[ Lowkey dont understand the significance of the above quote? spend some time thinking about it]

+ Information-Flow policies

  #highlight(fill: lime)[ Papers Goal]: build on the existing work of capability enforcement, while
  providing "mashup" designers (designers who combine multiple systems, secure or not), with a
  light and abstract way to specify security policies in source programs.

  \
  \
  - *EXAMPLE*

    Loan calculator application that opertes on secret data, but collects statistics about feature usage. Natural security policy is to
    assume the income is a secret source, the statistics gathering as a public sink, and require _noninterference_ (all outputs to the
    public sink are independent of inputs from secret source).

+ Transformation

  #highlight(fill: teal)[given an arbitrary source program in a simple imterative language, produces
  a secure program in a language with capabilities.]

  Two types of flows

  + Explicit Flows:  when secret data is passed to a public destination

    - To assign an expression to a variable, you require a
      capability to write to the variable. If expression contains a secret,
      the transformation ensures that no cap to write the value of the expression
      to the public sink is passed.

  + Implicit Flows : information is leaked through branching on secret data and exposing different publicly-observable behavior in branches.
    - When entering branches of a conditional with secret guard, or body of loop
    with secret guard, ensure that no capability to write the value of the expression to a public
    variable is passed.
    - #highlight(fill:yellow)[How are we ensuring that its not vulnerable to timing attacks based on secret value?]
      - i.e. the secret expression could proportional to \# of loop iterations.
      - is this relevant towards information flow control or something else? pretty sure it is

  + #highlight(fill: teal)[information flow can be tracked by controlling capabilities of code segments]
    - all that is needed are references and scopes
    - #highlight(fill: yellow)[ something about this statement feels rusty]

+ Security and Premissiveness
  + regardless of the source, the transformation output satisfies security conditions of
   non-interference
    - Does that mean its not capable of expressing other security clauses? 

  + the transformation is as permissive as dynamic monitoring, and the transformed program adheres
   to the same behavior as the source program.

  + their transformation can be seen as the inlining of a reference monitor into the program.

== Core 
- AFAIK their security model only targets non-interference, blocking the notion of
  release when appropriate.

- paper mostly talks about the rules and semantics behind their transformation.
- uses their inlined transformation to perform capability checks at runtime, with global state
  maps that hold "referential" capabilites infront of memory, protecting writes outward to
  public sinks. 

