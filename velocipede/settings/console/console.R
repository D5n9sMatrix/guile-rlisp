#!/usr/bin/r

# Condition Handling and Recovery
# Description
# These functions provide a mechanism for handling unusual conditions, including errors and warnings.

# Usage
# tryCatch(expr, ..., finally)
# withCallingHandlers(expr, ...)
# globalCallingHandlers(...)

# signalCondition(cond)

# simpleCondition(message, call = NULL)
# simpleError    (message, call = NULL)
# simpleWarning  (message, call = NULL)
# simpleMessage  (message, call = NULL)

# errorCondition(message, ..., class = NULL, call = NULL)
# warningCondition(message, ..., class = NULL, call = NULL)

# ## S3 method for class 'condition'
# as.character(x, ...)
# ## S3 method for class 'error'
# as.character(x, ...)
# ## S3 method for class 'condition'
# print(x, ...)
# ## S3 method for class 'restart'
# print(x, ...)

# conditionCall(c)
# ## S3 method for class 'condition'
# conditionCall(c)
# conditionMessage(c)
# ## S3 method for class 'condition'
# conditionMessage(c)

# withRestarts(expr, ...)

# computeRestarts(cond = NULL)
# findRestart(name, cond = NULL)
# invokeRestart(r, ...)
# tryInvokeRestart(r, ...)
# invokeRestartInteractively(r)

# isRestart(x)
# restartDescription(r)
# restartFormals(r)

# suspendInterrupts(expr)
# allowInterrupts(expr)

# .signalSimpleWarning(msg, call)
# .handleSimpleError(h, msg, call)
# .tryResumeInterrupt()
# Arguments
# c	
# a condition object.

# call	
# call expression.

# cond	
# a condition object.

# expr	
# expression to be evaluated.

# finally	
# expression to be evaluated before returning or exiting.

# h	
# function.

# message	
# character string.

# msg	
# character string.

# name	
# character string naming a restart.

# r	
# restart object.

# x	
# object.

# class	
# character string naming a condition class.

# ...	
# additional arguments; see details below.

# Details
# The condition system provides a mechanism for signaling and handling unusual conditions, including errors and warnings. Conditions are represented as objects that contain information about the condition that occurred, such as a message and the call in which the condition occurred. Currently conditions are S3-style objects, though this may eventually change.

# Conditions are objects inheriting from the abstract class condition. Errors and warnings are objects inheriting from the abstract subclasses error and warning. The class simpleError is the class used by stop and all internal error signals. Similarly, simpleWarning is used by warning, and simpleMessage is used by message. The constructors by the same names take a string describing the condition as argument and an optional call. The functions conditionMessage and conditionCall are generic functions that return the message and call of a condition.

# The function errorCondition can be used to construct error conditions of a particular class with additional fields specified as the ... argument. warningCondition is analogous for warnings.

# Conditions are signaled by signalCondition. In addition, the stop and warning functions have been modified to also accept condition arguments.

# The function tryCatch evaluates its expression argument in a context where the handlers provided in the ... argument are available. The finally expression is then evaluated in the context in which tryCatch was called; that is, the handlers supplied to the current tryCatch call are not active when the finally expression is evaluated.

# Handlers provided in the ... argument to tryCatch are established for the duration of the evaluation of expr. If no condition is signaled when evaluating expr then tryCatch returns the value of the expression.

# If a condition is signaled while evaluating expr then established handlers are checked, starting with the most recently established ones, for one matching the class of the condition. When several handlers are supplied in a single tryCatch then the first one is considered more recent than the second. If a handler is found then control is transferred to the tryCatch call that established the handler, the handler found and all more recent handlers are disestablished, the handler is called with the condition as its argument, and the result returned by the handler is returned as the value of the tryCatch call.

# Calling handlers are established by withCallingHandlers. If a condition is signaled and the applicable handler is a calling handler, then the handler is called by signalCondition in the context where the condition was signaled but with the available handlers restricted to those below the handler called in the handler stack. If the handler returns, then the next handler is tried; once the last handler has been tried, signalCondition returns NULL.

# globalCallingHandlers establishes calling handlers globally. These handlers are only called as a last resort, after the other handlers dynamically registered with withCallingHandlers have been invoked. They are called before the error global option (which is the legacy interface for global handling of errors). Registering the same handler multiple times moves that handler on top of the stack, which ensures that it is called first. Global handlers are a good place to define a general purpose logger (for instance saving the last error object in the global workspace) or a general recovery strategy (e.g. installing missing packages via the retry_loadNamespace restart).

# Like withCallingHandlers and tryCatch, globalCallingHandlers takes named handlers. Unlike these functions, it also has an options-like interface: you can establish handlers by passing a single list of named handlers. To unregister all global handlers, supply a single 'NULL'. The list of deleted handlers is returned invisibly. Finally, calling globalCallingHandlers without arguments returns the list of currently established handlers, visibly.

# User interrupts signal a condition of class interrupt that inherits directly from class condition before executing the default interrupt action.

# Restarts are used for establishing recovery protocols. They can be established using withRestarts. One pre-established restart is an abort restart that represents a jump to top level.

# findRestart and computeRestarts find the available restarts. findRestart returns the most recently established restart of the specified name. computeRestarts returns a list of all restarts. Both can be given a condition argument and will then ignore restarts that do not apply to the condition.

# invokeRestart transfers control to the point where the specified restart was established and calls the restart's handler with the arguments, if any, given as additional arguments to invokeRestart. The restart argument to invokeRestart can be a character string, in which case findRestart is used to find the restart. If no restart is found, an error is thrown.

# tryInvokeRestart is a variant of invokeRestart that returns silently when the restart cannot be found with findRestart. Because a condition of a given class might be signalled with arbitrary protocols (error, warning, etc), it is recommended to use this permissive variant whenever you are handling conditions signalled from a foreign context. For instance, invocation of a "muffleWarning" restart should be optional because the warning might have been signalled by the user or from a different package with the stop or message protocols. Only use invokeRestart when you have control of the signalling context, or when it is a logical error if the restart is not available.

# New restarts for withRestarts can be specified in several ways. The simplest is in name = function form where the function is the handler to call when the restart is invoked. Another simple variant is as name = string where the string is stored in the description field of the restart object returned by findRestart; in this case the handler ignores its arguments and returns NULL. The most flexible form of a restart specification is as a list that can include several fields, including handler, description, and test. The test field should contain a function of one argument, a condition, that returns TRUE if the restart applies to the condition and FALSE if it does not; the default function returns TRUE for all conditions.

# One additional field that can be specified for a restart is interactive. This should be a function of no arguments that returns a list of arguments to pass to the restart handler. The list could be obtained by interacting with the user if necessary. The function invokeRestartInteractively calls this function to obtain the arguments to use when invoking the restart. The default interactive method queries the user for values for the formal arguments of the handler function.

# Interrupts can be suspended while evaluating an expression using suspendInterrupts. Subexpression can be evaluated with interrupts enabled using allowInterrupts. These functions can be used to make sure cleanup handlers cannot be interrupted.

# .signalSimpleWarning, .handleSimpleError, and .tryResumeInterrupt are used internally and should not be called directly.

# References
# The tryCatch mechanism is similar to Java error handling. Calling handlers are based on Common Lisp and Dylan. Restarts are based on the Common Lisp restart mechanism.

# See Also
# stop and warning signal conditions, and try is essentially a simplified version of tryCatch. assertCondition in package tools tests that conditions are signalled and works with several of the above handlers.

# Examples
tryCatch(1, finally = print("Hello"))
e <- simpleError("test error")
## Not run: 
 stop(e)
 tryCatch(stop(e), finally = print("Hello"))
 tryCatch(stop("fred"), finally = print("Hello"))

## End(Not run)
tryCatch(stop(e), error = function(e) e, finally = print("Hello"))
tryCatch(stop("fred"),  error = function(e) e, finally = print("Hello"))
withCallingHandlers({ warning("A"); 1+2 }, warning = function(w) {})
## Not run: 
 { withRestarts(stop("A"), abort = function() {}); 1 }

## End(Not run)
withRestarts(invokeRestart("foo", 1, 2), foo = function(x, y) {x + y})

##--> More examples are part of
##-->   demo(error.catching)
