<?php
declare(strict_types=1);

const CONTACT_TO = 'help@tassietech.com.au';
const CONTACT_FROM = 'no-reply@tassietech.com.au';
const CONTACT_FROM_NAME = 'TassieTech Website';

function redirect_to(string $path): never
{
    header('Location: ' . $path, true, 303);
    exit;
}

function fail_submission(string $reason): never
{
    error_log('TassieTech contact form rejected: ' . $reason);
    redirect_to('/contact/?status=error');
}

function posted(string $key): string
{
    $value = $_POST[$key] ?? '';
    if (is_array($value)) {
        return '';
    }

    return trim((string) $value);
}

function clean_text(string $value, int $maxLength = 4000): string
{
    $value = str_replace(["\r\n", "\r"], "\n", $value);
    $value = strip_tags($value);
    $value = preg_replace('/[^\P{C}\n\t]+/u', '', $value) ?? '';
    $value = preg_replace("/\n{3,}/", "\n\n", $value) ?? '';

    return trim(substr($value, 0, $maxLength));
}

function header_text(string $value, int $maxLength = 120): string
{
    $value = preg_replace('/[\r\n]+/', ' ', $value) ?? '';
    $value = preg_replace('/\s+/', ' ', $value) ?? '';

    return trim(substr($value, 0, $maxLength));
}

function require_value(string $key, string $label, int $maxLength = 4000): string
{
    $value = clean_text(posted($key), $maxLength);
    if ($value === '') {
        fail_submission($label . ' missing');
    }

    return $value;
}

function send_contact_email(string $subject, array $lines, string $replyName, string $replyEmail): bool
{
    $safeSubject = header_text($subject);
    $safeReplyName = str_replace(['<', '>', '"'], '', header_text($replyName)) ?: 'Website enquiry';
    $body = implode("\n", $lines) . "\n";
    $headers = [
        'MIME-Version: 1.0',
        'Content-Type: text/plain; charset=UTF-8',
        'From: ' . CONTACT_FROM_NAME . ' <' . CONTACT_FROM . '>',
        'Reply-To: ' . $safeReplyName . ' <' . $replyEmail . '>',
        'X-Mailer: PHP/' . phpversion(),
    ];

    $sent = @mail(CONTACT_TO, $safeSubject, $body, implode("\r\n", $headers), '-f' . CONTACT_FROM);
    if (!$sent) {
        $sent = @mail(CONTACT_TO, $safeSubject, $body, implode("\r\n", $headers));
    }

    return $sent;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect_to('/contact/');
}

if (posted('website') !== '') {
    redirect_to('/thank-you/');
}

$name = require_value('name', 'Name', 160);
$email = trim(posted('email'));
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    fail_submission('Email invalid');
}

$submissionType = posted('submissionType');
if (!in_array($submissionType, ['individual', 'business'], true)) {
    fail_submission('Submission type invalid');
}

$lines = [
    'Website enquiry from tassietech.com.au',
    'Submitted: ' . date('c'),
    'IP address: ' . ($_SERVER['REMOTE_ADDR'] ?? 'unknown'),
    'User agent: ' . clean_text($_SERVER['HTTP_USER_AGENT'] ?? 'unknown', 300),
    '',
    'Name: ' . $name,
    'Email: ' . $email,
    'Submission type: ' . ucfirst($submissionType),
];

$subject = 'Website individual support request';

if ($submissionType === 'individual') {
    $issue = require_value('individualIssue', 'Individual issue outline');
    $lines[] = '';
    $lines[] = 'Issue outline:';
    $lines[] = $issue;
}

if ($submissionType === 'business') {
    $businessName = require_value('businessName', 'Business name', 180);
    $requestType = posted('businessRequestType');
    if (!in_array($requestType, ['project', 'support'], true)) {
        fail_submission('Business request type invalid');
    }

    $lines[] = 'Business name: ' . $businessName;
    $lines[] = 'Request type: ' . ucfirst($requestType);

    if ($requestType === 'project') {
        $allowedBudgets = ['Under $2,500', '$2,500 - $7,500', '$7,500 - $15,000', '$15,000 - $30,000', '$30,000+', 'Not sure yet'];
        $budgetRange = posted('budgetRange');
        if (!in_array($budgetRange, $allowedBudgets, true)) {
            fail_submission('Budget range invalid');
        }

        $projectOverview = require_value('projectOverview', 'Project overview');
        $subject = 'Website business project request - ' . $businessName;
        $lines[] = 'Budget range: ' . $budgetRange;
        $lines[] = '';
        $lines[] = 'Project overview:';
        $lines[] = $projectOverview;
    }

    if ($requestType === 'support') {
        $urgencyLabels = [
            'critical' => 'Critical - business-wide outage, suspected compromise, data loss risk, or operations stopped.',
            'high' => 'High - multiple people affected or a key workflow blocked, but the business can still operate.',
            'standard' => 'Standard - single-user issue, planned change, question, or non-urgent support request.',
        ];
        $urgency = posted('urgency');
        if (!array_key_exists($urgency, $urgencyLabels)) {
            fail_submission('Urgency invalid');
        }

        $supportIssue = require_value('supportIssue', 'Support issue outline');
        $subject = 'Website business support request (' . ucfirst($urgency) . ') - ' . $businessName;
        $lines[] = 'Urgency: ' . $urgencyLabels[$urgency];
        $lines[] = '';
        $lines[] = 'Issue outline:';
        $lines[] = $supportIssue;
    }
}

if (!send_contact_email($subject, $lines, $name, $email)) {
    fail_submission('Mail send failed');
}

redirect_to('/thank-you/');
