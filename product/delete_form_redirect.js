$(document).ready(function () {
    if (sessionStorage.getItem('showSuccessModal') === 'true') {
        const message = sessionStorage.getItem('deleteResponse');
        $('#successMessage').text(message);
        $('#successModal').modal('show');
        sessionStorage.removeItem('showSuccessModal');
        sessionStorage.removeItem('deleteResponse');
    }
});

$(document).ready(function () {
    // Intercept form submission
    $('#deleteForm').on('submit', function (e) {
        e.preventDefault(); // Prevent the default form submission

        // Send form data via AJAX
        $.ajax({
            url: 'delete.php', // Target PHP file for processing
            datatype: 'json',
            type: 'POST',
            data: $(this).serialize(),
            success: function (response) {
                // If there's an error message in the response, show the modal
                if (response.error) {
                    $('#errorMessage').text(response.error);
                    $('#errorModal').modal('show');
                } else if (!response.missing) {
                    sessionStorage.setItem('showSuccessModal', 'true');
                    sessionStorage.setItem('deleteResponse', response.success);
                    location.reload();
                }
                $('#Delete').modal('hide');
            },
            error: function () {
                alert('Something went wrong while sending deleting food request')
            }
        });
    });
});