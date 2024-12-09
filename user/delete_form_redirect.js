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
                    $('#successMessage').text(response.success);
                    $('#successModal').modal('show');
                }
                $('#Delete').modal('hide');
            },
            error: function () {
                alert('Something went wrong while sending deleting user request')
            }
        });
    });
});