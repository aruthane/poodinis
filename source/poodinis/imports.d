/**
 * This module contains instance factory facilities
 *
 * Authors:
 *  Mike Bierlee, m.bierlee@lostmoment.com
 * Copyright: 2014-2018 Mike Bierlee
 * License:
 *  This software is licensed under the terms of the MIT license.
 *  The full terms of the license can be found in the LICENSE file.
 */

module poodinis.imports;

import std.traits;

public static string createImportsString(Type)() {
    string imports = `import ` ~ moduleName!Type ~ `;`;
    static if (__traits(compiles, TemplateArgsOf!Type)) {
        foreach(TemplateArgType; TemplateArgsOf!Type) {
            static if (!isBuiltinType!TemplateArgType) {
                imports ~= createImportsString!TemplateArgType;
            }
        }
    }

    return imports;
}