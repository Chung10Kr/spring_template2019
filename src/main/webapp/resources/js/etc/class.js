class CheckboxRenderer{
    constructor(props) {
        const {grid,rowKey} = props;
        
        const id = String( grid.el.id+""+rowKey );
        /*const id = String(rowKey);*/
        
        const label = document.createElement('label');
        
        label.className = 'checkbox';
        label.setAttribute('for', id);

        const hiddenInput = document.createElement('input');
        hiddenInput.className = 'hidden-input';
        
        
        /*hiddenInput.id = String(rowKey);*/
        hiddenInput.id = id;

        const customInput = document.createElement('span');
        customInput.className = 'custom-input';

        label.appendChild(hiddenInput);
        label.appendChild(customInput);

        hiddenInput.type = 'checkbox';
        hiddenInput.addEventListener('change',function(){
            if (hiddenInput.checked) {
                grid.check( id );
            } else {
                grid.uncheck( id );
            }
        });

        this.el = label;

        this.render(props);
    };

    getElement(){
        return this.el;
    };

    render(props){
        const hiddenInput = this.el.querySelector('.hidden-input');
        const checked = Boolean(props.value);

        hiddenInput.checked = checked;
    };
};