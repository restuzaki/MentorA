import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_a/model/teacher_material_model.dart';
import 'package:mentor_a/screen/teacher/student_list_screen.dart';
import 'package:mentor_a/style/custom_color.dart';
import 'package:mentor_a/widget/attachment_bottom_sheet.dart';
import 'package:mentor_a/widget/attachment_item.dart';
import 'package:mentor_a/widget/custom_dropdown.dart';
import 'package:mentor_a/widget/custom_text_field.dart';
import 'package:mentor_a/widget/delete_confirmation_dialog.dart';
import 'package:mentor_a/widget/material_card.dart';
import 'package:mentor_a/widget/student_info_card.dart';

/// Screen for adding or editing a subject (teacher flow).
///
/// Features:
/// - Subject name input & class dropdown
/// - Student info card with "Lihat Daftar" / "Undangan" actions
/// - Material CRUD: add, edit, delete with inline form
/// - Attachment support (file mock & link dialog)
class AddSubjectTeacherScreen extends StatefulWidget {
  const AddSubjectTeacherScreen({super.key});

  @override
  State<AddSubjectTeacherScreen> createState() =>
      _AddSubjectTeacherScreenState();
}

class _AddSubjectTeacherScreenState extends State<AddSubjectTeacherScreen> {
  // ── Subject fields ──
  final _subjectNameController = TextEditingController();
  String? _selectedClass;
  final List<String> _classList = [
    '10A',
    '10B',
    '10C',
    '11A',
    '11B',
    '11C',
    '12A',
    '12B',
    '12C',
  ];

  // ── Materials ──
  final List<TeacherMaterial> _materials = [];

  // ── Inline material form state ──
  bool _isFormVisible = false;
  int? _editingIndex; // null = adding new, non-null = editing
  final _materialTitleController = TextEditingController();
  List<MaterialAttachment> _currentAttachments = [];

  // ── Helpers ──
  bool get _isEditing => _editingIndex != null;

  void _shareLink() async {
    const placeholderLink = 'https://mentora.app/invite/class-12345';
    await Clipboard.setData(const ClipboardData(text: placeholderLink));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link berhasil disalin ke clipboard'),
        backgroundColor: CustomColor.successGreen,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _subjectNameController.dispose();
    _materialTitleController.dispose();
    super.dispose();
  }

  // ─────────────────────── Material CRUD ───────────────────────

  void _showAddMaterialForm() {
    setState(() {
      _isFormVisible = true;
      _editingIndex = null;
      _materialTitleController.clear();
      _currentAttachments = [];
    });
  }

  void _showEditMaterialForm(int index) {
    final material = _materials[index];
    setState(() {
      _isFormVisible = true;
      _editingIndex = index;
      _materialTitleController.text = material.title;
      _currentAttachments = List.from(material.attachments);
    });
  }

  void _saveMaterial() {
    final title = _materialTitleController.text.trim();
    if (title.isEmpty) {
      _showSnackBar('Judul materi tidak boleh kosong', isError: true);
      return;
    }

    setState(() {
      if (_isEditing) {
        _materials[_editingIndex!] = TeacherMaterial(
          title: title,
          attachments: List.from(_currentAttachments),
        );
        _showSnackBar('Materi berhasil diperbarui');
      } else {
        _materials.add(
          TeacherMaterial(
            title: title,
            attachments: List.from(_currentAttachments),
          ),
        );
        _showSnackBar('Materi berhasil ditambahkan');
      }
      _cancelMaterialForm();
    });
  }

  void _cancelMaterialForm() {
    setState(() {
      _isFormVisible = false;
      _editingIndex = null;
      _materialTitleController.clear();
      _currentAttachments = [];
    });
  }

  Future<void> _deleteMaterial(int index) async {
    final confirmed = await DeleteConfirmationDialog.show(
      context,
      itemName: _materials[index].title,
    );
    if (!confirmed || !mounted) return;

    setState(() {
      _materials.removeAt(index);
    });
    _showSnackBar('Materi berhasil dihapus');
  }

  // ─────────────────────── Attachments ───────────────────────

  void _showAttachmentOptions() {
    AttachmentBottomSheet.show(
      context,
      onUploadFile: _mockFilePick,
      onAddLink: _showAddLinkDialog,
    );
  }

  void _mockFilePick() {
    // Simulate picking a file — replace with file_picker when available
    final mockFiles = [
      MaterialAttachment(
        name: 'Dokumen_materi.pdf',
        detail: '2105.6 KB',
        type: AttachmentType.file,
      ),
      MaterialAttachment(
        name: 'Video_penjelasan.mp4',
        detail: '43022.8 KB',
        type: AttachmentType.file,
      ),
    ];

    // Pick the first mock file that isn't already attached
    final existing = _currentAttachments.map((a) => a.name).toSet();
    final next = mockFiles.where((f) => !existing.contains(f.name)).firstOrNull;

    if (next != null) {
      setState(() => _currentAttachments.add(next));
    } else {
      _showSnackBar('Tidak ada file mock lagi', isError: true);
    }
  }

  void _showAddLinkDialog() {
    final linkNameController = TextEditingController();
    final linkUrlController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: CustomColor.backgroundColor,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and X button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tambah Link',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.textBlack,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: CustomColor.textGrey,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Judul Link (Opsional)',
              hintText: 'Pecahan',
              controller: linkNameController,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              label: 'URL Link',
              hintText: 'https://youtube.com/watch?v=...',
              controller: linkUrlController,
            ),
            const SizedBox(height: 20),
            // Full width button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final name = linkNameController.text.trim();
                  final url = linkUrlController.text.trim();
                  if (url.isEmpty) return;
                  setState(() {
                    _currentAttachments.add(
                      MaterialAttachment(
                        name: name.isEmpty ? 'pecahan' : name,
                        detail: url,
                        type: AttachmentType.link,
                      ),
                    );
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Tambahkan Link'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeAttachment(int index) {
    setState(() => _currentAttachments.removeAt(index));
  }

  // ─────────────────────── Navigation ───────────────────────

  void _navigateToStudentList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentListScreen(className: _selectedClass),
      ),
    );
  }

  void _saveSubject() {
    final name = _subjectNameController.text.trim();
    if (name.isEmpty) {
      _showSnackBar('Nama mata pelajaran tidak boleh kosong', isError: true);
      return;
    }
    if (_selectedClass == null) {
      _showSnackBar('Pilih kelas terlebih dahulu', isError: true);
      return;
    }
    _showSnackBar('Mata pelajaran berhasil disimpan');
    Navigator.pop(context);
  }

  // ─────────────────────── Snackbar ───────────────────────

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError
            ? CustomColor.errorRed
            : CustomColor.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ═════════════════════════ BUILD ═════════════════════════

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Mata Pelajaran',
          style: TextStyle(
            color: CustomColor.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        backgroundColor: CustomColor.backgroundColor,
        elevation: 0.5,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CustomColor.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSubjectInfoSection(),
                  const SizedBox(height: 16),
                  _buildStudentSection(),
                  const SizedBox(height: 20),
                  _buildMaterialSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildSaveSubjectButton(),
        ],
      ),
    );
  }

  // ─────────────────── Subject Info Section ───────────────────

  Widget _buildSubjectInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: 'Nama Mata Pelajaran',
          hintText: 'Contoh : Matematika',
          controller: _subjectNameController,
        ),
        const SizedBox(height: 16),
        CustomDropdown(
          label: 'Kelas',
          hintText: 'Pilih kelas',
          value: _selectedClass,
          items: _classList,
          onChanged: (value) => setState(() => _selectedClass = value),
        ),
      ],
    );
  }

  // ─────────────────── Student Section ────────────────────

  Widget _buildStudentSection() {
    return StudentInfoCard(
      studentCount: 0,
      onViewList: _navigateToStudentList,
      onInvite: () {
        _shareLink();
      },
    );
  }

  // ─────────────────── Material Section ────────────────────

  Widget _buildMaterialSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Materi / Sub Bab',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: CustomColor.textBlack,
              ),
            ),
            _buildAddMaterialChip(),
          ],
        ),
        const SizedBox(height: 12),

        // Inline add/edit form
        if (_isFormVisible) _buildMaterialForm(),

        // Saved materials list
        if (_materials.isNotEmpty)
          ..._materials.asMap().entries.map((entry) {
            final index = entry.key;
            final material = entry.value;
            return MaterialCard(
              chapterIndex: index,
              material: material,
              onEdit: () => _showEditMaterialForm(index),
              onDelete: () => _deleteMaterial(index),
            );
          }),

        // Empty state
        if (_materials.isEmpty && !_isFormVisible) _buildEmptyMaterialState(),
      ],
    );
  }

  Widget _buildAddMaterialChip() {
    return GestureDetector(
      onTap: _isFormVisible ? null : _showAddMaterialForm,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: CustomColor.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              'Tambah',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyMaterialState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: CustomColor.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CustomColor.borderGrey.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: CustomColor.textGrey, size: 28),
          ),
          const SizedBox(height: 12),
          const Text(
            'Belum ada materi. Klik tombol Tambah\nuntuk menambah materi',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: CustomColor.textGrey),
          ),
        ],
      ),
    );
  }

  // ─────────────────── Material Form ────────────────────

  Widget _buildMaterialForm() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isEditing ? 'Edit Materi' : 'Tambah Materi Baru',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: CustomColor.textBlack,
            ),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Judul Materi / Sub Bab',
            hintText: 'Contoh: Persamaan Linear',
            controller: _materialTitleController,
          ),
          const SizedBox(height: 16),

          // Attachments label
          const Text(
            'Lampiran (Opsional)',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: CustomColor.textBlack,
            ),
          ),
          const SizedBox(height: 8),

          // Attachment list
          ..._currentAttachments.asMap().entries.map((entry) {
            return AttachmentItem(
              attachment: entry.value,
              onRemove: () => _removeAttachment(entry.key),
            );
          }),

          // + Tambah attachment button
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _showAttachmentOptions,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Tambah',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Tambahkan file (dokumen, video) atau link pembelajaran',
                style: TextStyle(fontSize: 11, color: CustomColor.textGrey),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Save / Cancel buttons
          Row(
            children: [
              ElevatedButton(
                onPressed: _saveMaterial,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                child: Text(_isEditing ? 'Perbarui Materi' : 'Simpan Materi'),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: _cancelMaterialForm,
                style: OutlinedButton.styleFrom(
                  foregroundColor: CustomColor.textBlack,
                  side: const BorderSide(color: CustomColor.borderGrey),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                child: const Text('Batal'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────── Save Subject Button ────────────────────

  Widget _buildSaveSubjectButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: CustomColor.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _saveSubject,
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColor.accentColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        child: const Text('Simpan Mata Pelajaran'),
      ),
    );
  }
}
