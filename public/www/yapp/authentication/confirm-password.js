(function() {
    "use strict";

    var directiveId = "confirmPassword";

    angular
        .module("yapp.authentication")
        .directive(directiveId, ConfirmPassword);

    ConfirmPassword.$inject = ["$parse"];

    function ConfirmPassword($parse) {
        return {
            require: "?ngModel",
            restrict: "A",
            link: link
        };

        ////////////////////

        function link(scope, elm, attrs, ctrl) {
            if (!ctrl) return;
            if (!attrs[directiveId]) return;

            var firstPassword = $parse(attrs[directiveId]);

            ctrl.$parsers.unshift(validator);
            ctrl.$formatters.push(validator);
            attrs.$observe(directiveId, observe);

            ////////////////////

            function validator(value) {
                var temp = firstPassword(scope),
                    v = value === temp;
                ctrl.$setValidity('match', v);
                return value;
            }

            function observe() {
                validator(ctrl.$viewValue);
            }
        }

    }
})();