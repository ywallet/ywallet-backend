(function() {
    "use strict";

    angular
        .module("yapp.settings")
        .controller("PersonalData", PersonalData);

    PersonalData.$inject = ["$scope", "$auth", "StateRouter", "DSUser"];

    function PersonalData($scope, $auth, StateRouter, DSUser) {
        $scope.personalData = {
            name: "",
            email: ""
        };

        $scope.changeData = changeData;

        ////////////////////

        function changeData() {
            /*$rootScope.yUser = {
                name: $scope.personalData.name,
                email: $scope.personalData.email
            };
            StateRouter.goAndForget("yapp.dashboard");*/
            var data = { account_attributes: {} },
                yUser = DSUser.getUser(),
                key = yUser.role == "parent" ? "manager" : "child",
                name = $scope.personalData.name,
                email = $scope.personalData.email;
            if (!name && !email) { return; }
            data.id = yUser.id;
            if (name) {
                data.account_attributes.name = name;
            }
            if (email) {
                data.account_attributes.email = email;
            }
            // $auth.updateAccount(data).then(onUpdateSuccess, onUpdateError);
        }


        function onUpdateSuccess(resp) {
            resp = resp.data.data;
            resp.role = resp.children_ids != null ? "parent" : "child";
            console.log("UPDATED", resp);
            DSUser.putUser(resp);
            StateRouter.goAndForget("yapp.settings");
        }

        function onUpdateError(resp) {
            console.error("error authenticating", resp);
            StateRouter.goAndForget("yapp.settings");
        }
    }
})();