(function() {
    "use strict";

    angular
        .module("yapp.services")
        .factory("StateRouter", StateRouter);

    StateRouter.$inject = ["$rootScope", "$state"];

    function StateRouter($rootScope, $state) {
        return {
            goAndForget: goAndForget
        };

        ////////////////////

        function dangerous_forget() {
            var v,
                vh = $rootScope.$viewHistory,
                vs = vh.views,
                cv = vh.currentView,
                stack = vh.histories.root.stack;
            while (stack.length) {
                v = stack.pop();
                delete vs[v.viewId];
            }
            vh.backView = null;
            vh.forwardView = null;
            cv.backViewId = null;
            cv.forwardViewId = null;
            cv.index = 0;
        }


        function forget() {
            var vh = $rootScope.$viewHistory;
            vh.backView = null;
            vh.forwardView = null;
            vh.currentView = null;
        }


        function goAndForget(state) {
            forget();
            $state.go(state);
        }
    }
})();