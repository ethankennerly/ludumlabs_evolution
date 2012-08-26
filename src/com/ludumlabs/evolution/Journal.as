package com.ludumlabs.evolution
{
    import flash.utils.getTimer;

    public class Journal
    {
        public var previousRecord:int;
        public var previousUpdate:int;
        public var accumulated:int;
        public var nameMethods:Object;
        public var nameScopes:Object;
        public var delays:Array;
        public var methods:Array;
        public var methodArgs:Array;
        public var replayIndex:int;
        public var replaying:Boolean;
        public var recording:Boolean;
        public var verbose:Boolean = true;

        public function Journal()
        {
            var now:int = getTimer();
            previousRecord = now;
            previousUpdate = now;
            accumulated = 0;
            nameMethods = {};
            nameScopes = {};
            delays = [];
            methodArgs = [];
            methods = [];
            replayIndex = 0;
            recording = true;
            replaying = false;
        }

        /**
         * Wrap a function to record and apply the arguments in the same scope.
         */
        public function decorate(uniqueName:String, scope:*, funcName:String):Function
        {
            nameMethods[uniqueName] = funcName;
            nameScopes[uniqueName] = scope;
            var record:Function = function(... args:*):* {
                if (recording) {
                    var now:int = getTimer();
                    var delay:int = now - previousRecord;
                    delays.push(delay);
                    methodArgs.push(args);
                    methods.push(uniqueName);
                    if (verbose) {
                        // trace("Journal.record " + uniqueName + " delay " + delay + " args " + args);
                    }
                    previousRecord = now;
                }
                return apply(scope, funcName, args);
            }
            return record;
        }

        public function apply(scope:*, methodName:String, arg:Array):* {
            var result:*;
            if (0 == arg.length) {
                result = scope[methodName]();
            }
            else {
                result = scope[methodName].apply(scope, arg);
            }
            return result;
        }

        public function replay(immediately:Boolean = false, overrideScope:* = undefined):void
        {
            if (verbose) {
                trace("Journal.replay");
            }
            if (undefined !== overrideScope) {
                for (var s:String in nameScopes) {
                    nameScopes[s] = overrideScope;
                }
            }
            previousUpdate = getTimer();
            if (immediately && 1 <= delays.length) {
                previousUpdate -= delays[0];
            }
            accumulated = 0;
            replayIndex = 0;
            replaying = true;
        }

        public function update(now:int = -1):void
        {
            if (-1 == now) {
                now = getTimer();
            }
            accumulated += now - previousUpdate;
            if (replaying) {
                if (1 <= delays.length && replayIndex <= delays.length - 1) {
                    var delay:int = delays[replayIndex];
                    if (delay <= accumulated) {
                        var method:String = methods[replayIndex];
                        var undecorated:String = nameMethods[method];
                        if (undefined == undecorated) {
                            throw new ReferenceError("Expected method " + method + " in name methods.");
                        }
                        var arg:Array = methodArgs[replayIndex];
                        var scope:* = nameScopes[method];
                        if (verbose) {
                            trace("Journal.update: " + delay.toString() + " method " + undecorated 
                                + " replays " + replayIndex + " of " + delays.length 
                                + " accumulated " + accumulated);
                        }
                        apply(scope, undecorated, arg);
                        accumulated -= delay;
                        replayIndex = replayIndex + 1;
                    }
                }
            }
            previousUpdate = now;
        }
    }
}
