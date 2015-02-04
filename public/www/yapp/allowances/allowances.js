(function() {
    'use strict';

    angular
        .module('yapp.allowances')
        .controller('Allowances', Allowances)

    Allowances.$inject = ['$scope', '$ionicModal', 'DSAllowances'];
    function Allowances($scope, $ionicModal, DSAllowances)
    {
        DSAllowances.getAllowances().then(function(data){

            $scope.allowances = data;

            // Add Saving
            $scope.allowanceData = {};

            // Add Saving - Init Modal
            $ionicModal.fromTemplateUrl('yapp/allowances/addAllowance.html', {
                scope: $scope
            }).then(function(modal) {
                $scope.modal = modal;
            });

            $scope.openAddAllowance = function() {
                $scope.modal.show();
            };

            $scope.closeAddAllowance = function() {
                $scope.modal.hide();
            };

            $scope.addAllowance = function() {

                DSAllowances.addAllowance($scope.allowanceData.qty, $scope.allowanceData.period).then(function(data){

                    $scope.allowances.push(    {
                        "id": data.id,                         
                        "qty": $scope.allowanceData.qty,
                        "period": $scope.allowanceData.period,
                    });

                    $scope.allowanceData = {};
                    $scope.closeAddAllowance();
                });
            };

            // Remove Saving
            $scope.rmAllowance = function(id) {
                var lengthAllowances = $scope.allowances.length;
                var i = 0, index = -1;
                    
                for(; i < lengthAllowances && index == -1; i++)
                {
                    if( $scope.allowances[i].id == id )
                        index = i;
                }

                $scope.allowances.splice(index, 1);
                
                DSAllowances.rmAllowance(id);           
            }           
        });        
    }

})();