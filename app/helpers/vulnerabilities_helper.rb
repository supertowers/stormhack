module VulnerabilitiesHelper

  def vulnerability_categories
    [
      'Authentication',
      'Command Injection',
      'Cross-Site Request Forgery (CSRF)',
      'Cross-Site Scripting (XSS)',
      'Cryptographic Issue',
      'Denial of Service',
      'Information Disclosure',
      'Memory Corruption',
      'Privilege Escalation',
      'Remote Code Execution',
      'SQL Injection',
      'Clickjacking'
    ]
  end
end
