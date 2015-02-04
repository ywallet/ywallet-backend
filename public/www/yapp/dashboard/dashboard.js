(function() {
    "use strict";

    angular
        .module("yapp.dashboard")
        .controller("Dashboard", Dashboard);

    Dashboard.$inject = ["$scope", "DSUser"];

    function Dashboard($scope, DSUser) {
        console.log("Dashboard");
        $scope.yUser = DSUser.getUser();
			
				$scope.avaliable_amount = 123;
				$scope.allowance = 123;
				$scope.avaliable_amount = 123;
				$scope.next_allowance = 123;
				$scope.saved_amount = 123;
    }
})();