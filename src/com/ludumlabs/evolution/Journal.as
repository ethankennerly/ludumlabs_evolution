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
        public function decorate(uniqueName:String, scope:*, func:Function):Function
        {
            nameMethods[uniqueName] = func;
            nameScopes[uniqueName] = scope;
            var record:Function = function(... args:*):* {
                if (recording) {
                    var now:int = getTimer();
                    var delay:int = now - previousRecord;
                    delays.push(delay);
                    methodArgs.push(args);
                    methods.push(uniqueName);
                    if (verbose) {
                        trace("Journal.record " + uniqueName + " delay " + delay + " args " + args);
                    }
                    previousRecord = now;
                }
                return func.apply(scope, args);
            }
            return record;
        }

        public function replay(immediately:Boolean = false):void
        {
            if (verbose) {
                trace("Journal.replay");
            }
            previousUpdate = getTimer();
            if (immediately && 1 <= delays.length) {
                previousUpdate -= delays[0];
            }
            accumulated = 0;
            replaying = true;
        }

        public function update(now:int = -1):void
        {
            if (-1 == now) {
                now = getTimer();
            }
            accumulated += now - previousUpdate;
            if (replaying) {
                if (1 <= delays.length) {
                    var delay:int = delays[replayIndex];
                    if (delay <= accumulated) {
                        var method:String = methods[replayIndex];
                        if (undefined == nameMethods[method]) {
                            throw new ReferenceError("Expected method " + method + " in name methods.");
                        }
                        var arg:Array = methodArgs[replayIndex];
                        var scope:* = nameScopes[method];
                        if (verbose) {
                            trace("Journal.update: " + delay.toString() + " method " + method);
                        }
                        if (0 == arg.length) {
                            nameMethods[method]();
                        }
                        else {
                            nameMethods[method].apply(scope, arg);
                        }
                        accumulated -= delay;
                    }
                    replayIndex = (replayIndex++) % delays.length;
                }
            }
            previousUpdate = now;
        }
    }
}
