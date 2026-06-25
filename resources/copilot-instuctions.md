# GitHub Copilot Instructions
You are a **.NET 10 developer**. Always prioritize **solution correctness** and **performance optimization** in ever suggestion and code change.
Minimize files context scanning to required minimum.

## Code Search Rules
### RULE: Never use shell commands to search or read code - use built-in tools only
| Tool              | When to use 
|-------------------|-------------------------------
| `semantic_search` | Search by meaning or behavior
| `grep_search`     | Exact text or regex
| `file_search`     | File name or glob
| `read_file`       | Read a known file
## File Formatting Rules
### RULE: Every file must end with exactly one newline (`\n`) - do not add blank lines after the last line of content
### RULE: Do not modify any existing whitespace outside the lines being added or changed

## API Input Rules
### RULE: Add `[DefaultValue]` to every request input property that has a default value
Apply `[DefaultValue(...)]` from `System.ComponentModel` to every non-nullable property with an explicit initializer on any criteria, command, or query object. Skip nullable optional filters.

### RULE: Never materialize a collection that is directly returned from an endpoint

### RULE: Never materialize a collection that is directly returned from an endpoint 
Do not call `.ToList()` or `.ToArray()` on the final result before returning it - the ASP.NET Core JSO₩ serializer streams `IEnumerable<T>` in one pass. Skip this rule when the result is iterated more than once.

## RULE: Throw a dedicated domain exception for every endpoint business-rule violation
Never throw raw .NET exceptions (`Exception`, `InvalidOperationException`, etc.) or return `Results.BadRequest(...)`. The middleware maps domain exceptions to `FileNotFound` automatically - the class name becomes `title`. Name the class so it is self-explanatory without any message. Place it in the same project/layer as the throw site.

| Interface                                       | Use when                       | Exposes           |
|-------------------------------------------------|--------------------------------|-------------------|
|`IExposeExceptionAsNotFound`                     | Class name alone is sufficient | `title`           |
|`IExposeExceptionAsNotFoundWithMessageAsDetails` | Message adds client context    | `title` + `detail`|

## Documentation Rules
### RULE: Use XML doc comments (`///`) for every public class, method, and constructor
Use ` <summary>`, `<param>`, `<returns>`, and `<see cref-"..."/>` for referenced types, Skip trivial boilerplate.

## Integration Test Rules
### RULE: Every `[Test]` must have a `[Description]` using GIVEN (system state)  / WHEN (action) / THEN (business outcome)- THEN must state business intent, never an HTTP status code

### RULE: In happy-path tests assert changed properties first, then every unchanged property against the pre-action snapshot

### RULE: Assert complex-type properties by casting with `ShouldBeOfType<T>()` then asserting each field individually - never use `ShouldBeEquivalentTo`

### RULE: Assert domain exception identity via `ex.Result.Title`, not only the status code

### RULE: Assert validator errors via `GetRawText()` on the errors JsonElement
