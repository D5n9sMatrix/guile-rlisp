#!/usr/bin/r

# Utilities for Managing Class Definitions

# Description
# These are various functions to support the definition and use of formal classes. Most of them are rarely suitable to be called directly.

# Others are somewhat experimental and/or partially implemented only. Do refer to setClass for normal code development.

# Usage
# classLabel(Class)
# .classEnv(Class, default = .requirePackage("methods"), mustFind = TRUE)

# testVirtual(properties, extends, prototype, where)

# makePrototypeFromClassDef(slots, ClassDef, extends, where)

# newEmptyObject()

# completeClassDefinition(Class, ClassDef, where, doExtends)

# getAllSuperClasses(ClassDef, simpleOnly = TRUE)

# superClassDepth(ClassDef, soFar, simpleOnly = TRUE)

# isVirtualClass(Class, where)

# newBasic(Class, ...)

# makeExtends(Class, coerce, test, replace, by, package, slots,
#             classDef1, classDef2)

# reconcilePropertiesAndPrototype(name, properties, prototype,
#                                 superClasses, where)
# tryNew(Class, where)

# empty.dump()

# showClass(Class, complete=TRUE, propertiesAreCalled="Slots")

# showExtends(ext, printTo = stdout())

# possibleExtends(class1, class2,
#                 ClassDef1 = getClassDef(class1),
#                 ClassDef2 = getClassDef(class2, where = .classEnv(ClassDef1)))

# completeExtends(ClassDef, class2, extensionDef, where)

# classMetaName(name)

# methodsPackageMetaName(prefix, name, package = "")

# metaNameUndo(strings, prefix, searchForm = FALSE)

# requireMethods(functions, signature, message, where)

# checkAtAssignment(cl, name, valueClass)
# checkSlotAssignment(obj, name, value)

# defaultPrototype()

# isClassDef(object)

# validSlotNames(names)

# getDataPart(object, NULL.for.none = FALSE)
# setDataPart(object, value, check = TRUE)
# Summary of Functions
# testVirtual:
# Test for a Virtual Class. Figures out, as well as possible, whether the class with these properties, extension, and prototype is a virtual class. Can be forced to be virtual by extending "VIRTUAL".

# Otherwise, a class is virtual only if it has no slots, extends no non-virtual classes, and has a NULL Prototype.

# makePrototypeFromClassDef:
# Makes the prototype implied by the class definition.

# The following three rules are applied in this order.

# If the class has slots, then the prototype for each slot is used by default, but a corresponding element in the explicitly supplied prototype in ClassDef, if there is one, is used instead (but it must be coercible to the class of the slot). This includes the data part (".Data" slot) if there is one.

# If there are no slots but a non-null prototype was specified, this is returned.

# If there is a non-virtual superclass (a class in the extends list), then its prototype is used. The data part is extracted if needed (it is allowed to have two superclasses with a data part; the first is used and a warning issued on any others).

# If all three of the above fail, the prototype is NULL.

# newEmptyObject:
# Utility function to create an empty object into which slots can be set.

# Currently just creates an empty list with class "NULL".

# Later version should create a special object reference that marks an object currently with no slots and no data.

# completeClassDefinition:
# Completes the definition of Class, relative to the class definitions visible from environment where. If doExtends is TRUE, complete the super- and sub-class information.

# This function is called when a class is defined or re-defined.

# getFromClassDef:
# Extracts one of the intrinsically defined class definition properties (".Properties", etc.) Strictly a utility function.

# getSlots:
# Returns a named character vector. The names are the names of the slots, the values are the classes of the corresponding slots. The argument x can either be the name of a class or the class definition object.

# getAllSuperClasses, superClassDepth:
# Get the names of all the classes that this class definition extends.

# getAllSuperClasses is a utility function used to complete a class definition. It returns all the superclasses reachable from this class, in breadth-first order (which is the order used for matching methods); that is, the first direct superclass followed by all its superclasses, then the next, etc. (The order is relevant only in the case that some of the superclasses have multiple inheritance.)

# superClassDepth, which is called from getAllSuperClasses, returns the same information, but as a list with components label and depth, the latter for the number of generations back each class is in the inheritance tree. The argument soFar is used to avoid loops in the network of class relationships.

# isVirtualClass:
# Is the named class a virtual class?

# A class is virtual if explicitly declared to be, and also if the class is not formally defined.

# assignClassDef:
# assign the definition of the class to the specially named object

# newBasic:
# the implementation of the function new for basic classes that don't have a formal definition.

# Any of these could have a formal definition, except for Class="NULL" (disallowed because NULL can't have attributes). For all cases except "NULL", the class of the result will be set to Class.

# See new for the interpretation of the arguments.

# makeExtends:
# Construct an SClassExtension object representing the relationship from Class to the class defined by classDef2.

# reconcilePropertiesAndPrototype:
# makes a list or a structure look like a prototype for the given class.

# Specifically, returns a structure with attributes corresponding to the slot names in properties and values taken from prototype if they exist there, from new(classi) for the class, classi of the slot if that succeeds, and NULL otherwise.

# The prototype may imply slots not in the properties list, since properties does not include inherited slots (these are left unresolved until the class is used in a session).

# tryNew:
# Tries to generate a new element from this class, but if the attempt fails (as, e.g., when the class is undefined or virtual) just returns NULL.

# This is inefficient and also not a good idea when actually generating objects, but is useful in the initial definition of classes.

# showClass:
# Print the information about a class definition.

# If complete is TRUE, include the indirect information about extensions.

# It is the utility called from show(getClass(.)), and the user should typically use getClass(.) for looking at class definitions.

# showExtends:
# Print the elements of the list of extensions; for printTo = FALSE, returns a list with components what and how; this is used e.g., by promptClass().

# possibleExtends:
# Find the information that says whether class1 extends class2, directly or indirectly.

# This can be either a logical value or an object of class SClassExtension containing various functions to test and/or coerce the relationship.

# classLabel:
# Returns an informative character string identifying the class and, if appropriate, the package from which the class came.

# .classEnv:
# Returns the environment, typically a namespace, in which the Class has been defined. Class should typically be the result of class() (and hence contain a "package" attribute) or getClass (or getClassDef).

# completeExtends:
# complete the extends information in the class definition, by following transitive chains.

# If class2 and extensionDef are included, this class relation is to be added. Otherwise just use the current ClassDef.

# Both the contains and subclasses slots are completed with any indirect relations visible.

# classMetaName:
# a name for the object storing this class's definition

# methodsPackageMetaName:
# a name mangling device to hide metadata defining method and class information.

# metaNameUndo
# As its name implies, this function undoes the name-mangling used to produce meta-data object names, and returns a object of class ObjectsWithPackage.

# requireMethods:
# Require a subclass to implement methods for the generic functions, for this signature.

# For each generic, setMethod will be called to define a method that throws an error, with the supplied message.

# The requireMethods function allows virtual classes to require actual classes that extend them to implement methods for certain functions, in effect creating an API for the virtual class.

# Otherwise, default methods for the corresponding function would be called, resulting in less helpful error messages or (worse still) silently incorrect results.

# checkSlotAssignment, checkAtAssignment:
# Check that the value provided is allowed for this slot, by consulting the definition of the class. Called from the C code that assigns slots.

# For privileged slots (those that can only be set by accessor functions defined along with the class itself), the class designer may choose to improve efficiency by validating the value to be assigned in the accessor function and then calling slot<- with the argument check=FALSE, to prevent the call to checkSlotAssignment.

# defaultPrototype:
# The prototype for a class which will have slots, is not a virtual class, and does not extend one of the basic classes. Both its class and its (R internal) type, typeof(), are "S4".

# .InitBasicClasses, .InitMethodsListClass, .setCoerceGeneric:
# These functions perform part of the initialization of classes and methods, and are called (only!) from .onLoad.

# isClassDef:
# Is object a representation of a class?

# validSlotNames:
# Returns names unless one of the names is reserved, in which case there is an error. (As of writing, "class" is the only reserved slot name.)

# getDataPart, setDataPart:
# Utilities called to implement object@.Data. Calls to setDataPart are also used to merge the data part of a superclass prototype.

# Examples

typeof(defaultPrototype()) #-> "S4"

## .classEnv()
meth.ns <- asNamespace("methods")
if(get4 <- !any("package:stats4" == search()))
   require("stats4")
stopifnot(TRUE
 , identical(.classEnv("data.frame"), meth.ns)
 , identical(.classEnv(class(new("data.frame"))), meth.ns)
 , identical(.classEnv(     "mle"       ), meth.ns) # <- *not* 'stats4'
 , identical(.classEnv(class(new("mle"))), asNamespace("stats4"))
 , identical(.classEnv(getClass ("mle") ), asNamespace("stats4"))
 )
if(get4) detach("package:stats4")
