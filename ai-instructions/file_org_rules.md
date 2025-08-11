When implementing features:

- ASK FIRST - If the user doesn't specify where something should go, ask them
- MINIMAL IMPLEMENTATION - Only implement exactly what's requested, nothing more
- ONE RESPONSIBILITY - Each file should have ONE clear purpose
- NO ASSUMPTIONS - Don't add:
    - Helper classes unless explicitly requested
    - Complex abstractions unless specified
    - Multiple files when one was requested
    - Registry patterns unless asked for
    - Preset classes unless requested

File Organization Principles:
- Don't create new files unless explicitly requested

When in doubt:
- Implement the minimal version first
- Ask: "Should I also add [feature X] or keep it simple?"
- Respect existing file purposes
- Don't reorganize unless asked

Red flags that mean STOP and ASK:

- Adding more than one class to a file when only one was requested
- Creating wrapper patterns without being asked
- Adding registry or management systems
- Moving logic between files without permission
- Creating "smart" defaults or behaviors beyond basic requirements
