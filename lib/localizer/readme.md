In this section, I aimed to eliminate the redundancy of the UI in each localization approach by extracting everything related to localization into an external interface.

Each approach—`flutter_localizations`, `easy_localization`, and `easiest_localization`—would implement this interface.

This way, the differences in the approaches could be seen only in the localization logic, while all other aspects would be abstracted out to avoid distraction.