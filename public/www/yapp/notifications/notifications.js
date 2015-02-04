(function() {
    'use strict';

    angular
        .module('yapp.notifications')  
        .controller('Notifications', Notifications);

    Notifications.$inject = ['$scope', 'DSNotifications'];
    function Notifications($scope, DSNotifications)
    {

        /*DSNotifications.addNotification('type1', 'Mesada', 'Recebeu o seu pagamento mensal');
        DSNotifications.addNotification('type2', 'Iphone 6', 'Faltam 5 dias para atingir a poupança');
        DSNotifications.addNotification('type3', 'Crédito Extra', 'Recebeu um crédito na sua conta');
        DSNotifications.addNotification('type4', 'Semanada', 'Recebeu o seu pagamento semanal');*/
        
        $scope.rmNotification = function(index) {
            DSNotifications.rmNotification(index);            
        }
    }

})();