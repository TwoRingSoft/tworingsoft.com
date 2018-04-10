<!-- thanks to: http://www.phpnerds.com/article/building-a-secure-contact-form -->
<?php
$emailMessage = $_POST['Message'];
$emailFrom = $_POST['Email'];
$emailFromName = $_POST['Name'];

if (empty($emailMessage)) {
    echo 'You must enter a message to send to our team.';
} else {
    $emailTo = 'andrew+weblead@tworingsoft.com';
    
    if (!empty($emailFrom)) {
        $emailHeaders = 'From: "' . $emailFromName . '" <' . $emailFrom . '>';
    } else {
        echo 'Please enter an email address at which you may be contacted.'
    }
    
    if (mail($emailTo, 'Project lead from website', $emailMessage, $emailHeaders)) {
        echo 'Your message has been sent! Keep an eye out for a reply soon.';
    } else {
        echo 'There was an problem sending your email, please try again later or reach out on social media.';
    }
}
?>
<!-- /thanks -->
