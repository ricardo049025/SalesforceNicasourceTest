import { LightningElement, api, wire,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import CreateAccount from '@salesforce/apex/HelperManageAccount.CreateAccount';
import CreateContract from '@salesforce/apex/HelperManageAccount.CreateContract';


export default class AccountPage extends LightningElement {

    @track stept1 = true;
    @track stept2 = false;
    @track enableStept2 = true;


    @track accountId;
    @track contractId;

    Record = { Name: '', Phone: '', Fax: '', Website: ''};
    contract = {AccountId: '', Status:'Draft', ContractTerm:'', StartDate: '',OwnerExpirationNotice: ''}

    //methods for moving back and forward
    nextStept(){
        this.stept1 = false;
        this.stept2 = true;
    }
    
    backStept(){
        window.location.reload();
    }

    //build record of the object
    handleInputChangeForm(event){
            
        if(event.target.name == "Name"){
            this.Record.Name = event.target.value;
        } else if(event.target.name == "Phone"){
            this.Record.Phone = event.target.value;
        } else if(event.target.name == "Fax"){
            this.Record.Fax = event.target.value;
        }else if(event.target.name == "Website"){
            this.Record.Website = event.target.Website;
        }
        
    }

    handlerSaveAccount(){

        //validation
        if(this.Record.Name == ""){
            const event = new ShowToastEvent({
                title: 'Validation',
                message: 'Please complete the required fields',
                variant: 'warning'
            });

            this.dispatchEvent(event);
        }

        CreateAccount({
            account: JSON.stringify(this.Record)
        })
        .then(result => {
            if(result != ''){
                this.enableStept2 = false;
                this.accountId = result;
                this.contract.AccountId = result;
                const event = new ShowToastEvent({
                    title: 'success',
                    message: 'Created Account !',
                    variant: 'success'
                });
    
                this.dispatchEvent(event);


            }
        })
        .catch(error => {
            const event = new ShowToastEvent({
                title: 'Validation',
                message: 'error: ' + error,
                variant: 'error'
            });

            this.dispatchEvent(event);
        })

    }
    

    handleInputChangeFormContract(event){
            
        if(event.target.name == "OwnerExpirationNotice"){
            this.contract.OwnerExpirationNotice = event.target.value;
        } else if(event.target.name == "ContractTerm"){
            this.contract.ContractTerm = event.target.value;
        } else if(event.target.name == "StartDate"){
            this.contract.StartDate = event.target.value;
        } 
        console.log(this.contract);
    }

    handlerSaveContract(){
        
        CreateContract({
            con: JSON.stringify(this.contract)
        })
        .then(result => {

            if(result != ''){
                const event = new ShowToastEvent({
                    title: 'success',
                    message: 'Contract Created !',
                    variant: 'success'
                });
    
                this.dispatchEvent(event);
            }else{
                const event = new ShowToastEvent({
                    title: 'Validation',
                    message: 'Internal error ' + error,
                    variant: 'error'
                });
    
                this.dispatchEvent(event);
            }
        })
        .catch(error => {
            alert(error);
        })

    }

}