(function() {
    "use strict";

    angular
        .module("yapp.dashboard")
        .controller("Dashboard", Dashboard);

    Dashboard.$inject = ["$scope", "DSUser"];

    function Dashboard($scope, DSUser) {
        console.log("Dashboard");
        $scope.yUser = DSUser.getUser();
    }
})();