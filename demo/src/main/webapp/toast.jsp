<div class="position-fixed top-0 start-50 translate-middle-x p-3" style="z-index: 11">
    <div id="myToast" class="toast text-white" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="2000">
        <div class="d-flex">
            <div class="toast-body">
                <div class="icon-toast">
                    <i class="bi bi-check-lg"></i>
                </div>
                <div id="toast-content">Content</div>
            </div>
            
            <button type="button" class="btn-close btn-close-black me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>

<style>
    .toast-body {
        display: flex;
        width: 100%;
        align-items: center;
    }
    
    .icon-toast {
        display: flex;
        background-color: #30C894;
        width: 32px;
        height: 32px;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        margin-right: 15px;
    }
    
    .icon-toast i {
        color: #2161CC;
    }
    
    #toast-content {
       color: #000;
    }
</style>