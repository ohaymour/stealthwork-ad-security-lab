# \# Stealthwork: Secure Group Policy \& File Services Baseline

# 

# \## Objective

# Designed, deployed, and secured a multi-server Windows Server 2022 Active Directory environment aligned to NIST 800-171 / CMMC controls, built independently in VMware Workstation Pro.

# 

# \## Environment

# \- \*\*Hypervisor:\*\* VMware Workstation Pro

# \- \*\*OS:\*\* Windows Server 2022 Standard (Desktop Experience)

# \- \*\*Domain:\*\* lab.local

# \- \*\*Network:\*\* Isolated VMnet1 host-only network, 192.168.10.0/24, static IPs

# \- \*\*Servers:\*\*

# &#x20; - `DC01` (192.168.10.10) — Domain Controller, DNS, WSUS, GPO management

# &#x20; - `FS01` (192.168.10.20) — File Server (IT$, Finance$, HR$, Common$ shares)

# 

# \## Architecture

# See `/diagrams` for the network topology and permission-model diagrams.

# 

# \## Implementation

# 

# \### Identity \& Access Management

# \- Production-style OU hierarchy: `Lab > Users > IT / Finance / HR`, plus `Computers`, `Servers`, and `Groups` OUs.

# \- 4 security groups: `GRP\_IT`, `GRP\_Finance`, `GRP\_HR`, `GRP\_Admins`.

# \- \*\*Group-based, least-privilege permission model\*\* across all file shares — no individual user ACLs anywhere in the environment.

# 

# \### File Services

# | Share | NTFS Permission | Share Permission | Hidden |

# |---|---|---|---|

# | IT$ | GRP\_IT: Modify \\| GRP\_Admins: Full | GRP\_IT: Change \\| GRP\_Admins: Full | Yes |

# | Finance$ | GRP\_Finance: Modify \\| GRP\_Admins: Full | GRP\_Finance: Change \\| GRP\_Admins: Full | Yes |

# | HR$ | GRP\_HR: Modify \\| GRP\_Admins: Full | GRP\_HR: Change \\| GRP\_Admins: Full | Yes |

# | Common$ | Domain Users: Read \& Execute \\| GRP\_Admins: Full | Authenticated Users: Read \\| GRP\_Admins: Full | Yes |

# 

# \### Group Policy (7 GPOs — full detail in \[`/docs/GPO-Catalog.md`](docs/GPO-Catalog.md))

# 1\. \*\*Lab-Password-Policy\*\* — 14-char minimum, complexity, lockout after 5 attempts (NIST 3.5.6, 3.5.7)

# 2\. \*\*Lab-Audit-Policy\*\* — advanced audit logging: logon, object access, account management (NIST 3.3.1, 3.3.2)

# 3\. \*\*Lab-Drive-Maps\*\* — item-level-targeted drive mapping by department group (NIST 3.1.1)

# 4\. \*\*Lab-RDP-Hardening\*\* — NLA + TLS + firewall-restricted RDP (NIST 3.1.12, 3.13.6, 3.13.8)

# 5\. \*\*Lab-Software-Restriction\*\* — default-disallowed execution policy (NIST 3.4.8)

# 6\. \*\*Lab-WSUS-Policy\*\* — centralized patch management redirection (NIST 3.14.1)

# 7\. \*\*Lab-Hardening\*\* — firewall, guest account disabled, logon banner, SMB signing (NIST 3.1.1, 3.1.9, 3.13.6)

# 

# \### Patch Management \& Security Verification

# \- WSUS installed on DC01 with daily synchronization (Critical, Security, Definition updates).

# \- Verified SMBv1 disabled and SMB signing enforced on both servers via PowerShell (`Get-SmbServerConfiguration`).

# \- Confirmed GPO security settings applied via Event Viewer (Event ID 1704, SceCli).

# 

# \### Automation

# Three PowerShell scripts in \[`/scripts`](scripts/):

# \- `SetStaticIP.ps1` — static IP/DNS configuration

# \- `New-OUStructure.ps1` — builds the full OU hierarchy

# \- `New-LabGroups.ps1` — provisions all 4 security groups

# 

# \## Challenges \& Troubleshooting

# 

# \*\*1. GPO not applying\*\*

# Diagnosed a removed GPO link using `gpresult /r`; resolved by re-linking the policy and confirming reapplication.

# 

# \*\*2. Incorrect WSUS URL\*\*

# Diagnosed via Event Viewer (WSUS Event ID 12072) and a PowerShell registry check; resolved by correcting the GPO and verifying via registry.

# 

# \*\*3. File-share access denied\*\*

# Diagnosed a security group membership change using `rsop.msc`; resolved via `Add-ADGroupMember` and confirmed restored access.

# 

# \## Lessons Learned

# Building this from scratch — rather than following a fixed tutorial — meant most of the real learning came from the troubleshooting, not the initial setup. Getting comfortable reading Event Viewer and `gpresult` output well enough to diagnose issues quickly was the most valuable part of the project.

# 

# \## Skills Demonstrated

# Active Directory · Group Policy · Identity \& Access Management · NTFS Permissions · WSUS · PowerShell · NIST 800-171 Awareness · VMware Workstation

