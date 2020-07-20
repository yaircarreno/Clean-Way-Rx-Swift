# Book: The Clean Way to Use Rx

- [English Version](https://leanpub.com/the-clean-way-to-use-rx)
- [Spanish Version](https://leanpub.com/the-clean-way-to-use-rx-spanish)

This work, groups the different practices used in the implementation of software components through *Rx* extensions. These practices are organized into **35 application items**, and for each item, it is analyzed, which are the recommended code practices and the practices to avoid.

It could also be said that this document is the compilation of good practices learned through the own experience acquired in business projects, recommendations received from forums, blogs, workshops and in general from analyzes given by experts in the area, including the recommendations given in the official sites of each extension.

This book is also intended as a practical reference manual for implementing *Rx* code. That is why much of the book's material consists of examples of *code snippets* written in the main programming languages ​​for both Frontend (Mobile, Web; that is, JavaScript, Swift, Java) such as Backend.

The concepts studied in each of the items are agnostic to the programming language, there are few cases in which a certain capacity is not available in an extension and in which case the respective annotation is made in the item.

It is intended that once the concepts of each item have been studied, the reader benefits from a greater understanding of how *Rx* works.

Readers will also be equipped with tools to apply good practices that are ultimately reflected in the solutions in the area of:

- Clean Code.
- Best performance:
- Mitigate bugs scenarios.

![Book: The Clean Way to Use Rx](https://github.com/yaircarreno/Clean-Way-Rx-Swift/blob/master/screenshot/the-clean-may-to-use-rx.png)

## Rules summary

### Foundation

**Ítem 1**: [From Imperative to Reactive](#item-1)

**Ítem 2**: [Focus on pure functions](#item-2)

**Ítem 3**: [Check the nature of the streams when they are linked](#item-3)

**Ítem 4**: [Decide when to use an Observable type empty or never](#item-4)

### Be Clean

**Ítem 5**: [Keep clean the operators' chain](#item-5)

**Ítem 6**: [Define functional operator chains](#item-6)

**Ítem 7**: [Do not nest subscriptions, use operator chain](#item-7)

**Ítem 8**: [Use Rx when there are events involved](#item-8)

**Ítem 9**: [Do not orchestrate Rx operations with imperative programming](#item-9)

**Ítem 10**: [Do not include Rx code in Do operators](#item-10)

**Ítem 11**: [Propagate wrappers, not units](#item-11)

**Ítem 12**: [Avoid propagating null values, turn to Optionals](#item-12)

**Ítem 13**: [Remember you can use a filter, instead of if sentence](#item-13)

**Ítem 14**: [It is possible to divide the emission when if-else is presented](#item-14)

**Ítem 15**: [Sharing code is not the same as sharing emissions](#item-15)

**Ítem 16**: [Not everything is delegated to the Observer](#item-16)

**Ítem 17**: [Delay as much as possible the definition of the Schedule](#item-17)

### Flow dependencies

**Ítem 18**: [Check completion or error events when using filters](#item-18)

**Ítem 19**: [Beware of reduction operators on infinite streams](#item-19)

**Ítem 20**: [Maintain consistency like the stream](#item-20)

**Ítem 21**: [Be careful when you depend on onComplete](#item-21)

**Ítem 22**: [An additional step in the operator chain](#item-22)

**Ítem 23**: [Orchestrating and combining effectively](#item-23)

### Operators

**Ítem 24**: [Properly select operators](#item-24)

**Ítem 25**: [Use the map operator only for transformations](#item-25)

### Timing

**Ítem 26**: [Make sure you execute the tasks at the right time](#item-26)

**Ítem 27**: [Control execution times on dependent tasks](#item-27)


### Error handling

**Ítem 28**: [Handling errors](#item-28)

### Multicasting

**Ítem 29**: [Share Observables, share Observers or both](#item-29)

### Multi-threading

**Ítem 30**: [Rx is single-threaded by default](#item-30)

**Ítem 31**: [Do the order of the subscribeOn and observeOn operators matter?](#item-31)

**Ítem 32**: [Some operators bring a predefined Scheduler](#item-32)

**Ítem 33**: [Negotiating with UI](#item-33)

### Optimizing

**Ítem 34**: [Properly canceling the subscription](#item-34)

**Ítem 35**: [When to use Subjects or Traits?](#item-35)

## Versions of IDEs and technologies used.

- Xcode 11.5 - Swift 5
- Android Studio 4.0 - Java 1.8.0
- Visual Studio Code 1.47.1 - TypeScript 3.8.3 - Angular 9.1.0

## Other technologies

The reader will also be able to access the public repositories written for each technology at:

- [Clean Way Rx in JavaScript](https://github.com/yaircarreno/Clean-Way-Rx-JavaScript)
- [Clean Way Rx in Swift](https://github.com/yaircarreno/Clean-Way-Rx-Swift)
- [Clean Way Rx in Java](https://github.com/yaircarreno/Clean-Way-Rx-Java)
