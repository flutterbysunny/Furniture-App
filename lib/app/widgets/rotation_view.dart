import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// ThreeSixtyViewer
/// ─────────────────────────────────────────────────────────────────────────────
/// Horizontally drag karo to rotate product in 360°.
///
/// [frames]      : 36 image URLs (har 10° angle ke liye ek URL)
/// [height]      : widget ki height
/// [sensitivity] : kitne pixels drag karne par ek frame change hoga
/// ─────────────────────────────────────────────────────────────────────────────
class ThreeSixtyViewer extends StatefulWidget {
  final List<String> frames;
  final double height;
  final double sensitivity;

  const ThreeSixtyViewer({
    super.key,
    required this.frames,
    this.height = 280,
    this.sensitivity = 6.0,
  });

  @override
  State<ThreeSixtyViewer> createState() => _ThreeSixtyViewerState();
}

class _ThreeSixtyViewerState extends State<ThreeSixtyViewer>
    with SingleTickerProviderStateMixin {
  int _currentFrame = 0;
  double _dragAccumulator = 0;
  bool _isDragging = false;
  bool _hasInteracted = false;

  // Auto-rotate animation
  late AnimationController _autoRotateCtrl;

  @override
  void initState() {
    super.initState();

    // Auto-rotate on open, ruk jaao jab user drag kare
    _autoRotateCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..addListener(() {
      if (!_isDragging && widget.frames.isNotEmpty) {
        final targetFrame =
            (_autoRotateCtrl.value * widget.frames.length).floor() %
                widget.frames.length;
        if (targetFrame != _currentFrame) {
          setState(() => _currentFrame = targetFrame);
        }
      }
    });

    _autoRotateCtrl.repeat();
  }

  @override
  void dispose() {
    _autoRotateCtrl.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails _) {
    _autoRotateCtrl.stop(); // auto-rotate band karo
    setState(() {
      _isDragging = true;
      _hasInteracted = true;
    });
  }

  void _onDragEnd(DragEndDetails _) {
    setState(() => _isDragging = false);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _dragAccumulator += details.delta.dx;
    final steps = (_dragAccumulator / widget.sensitivity).truncate();
    if (steps != 0) {
      _dragAccumulator -= steps * widget.sensitivity;
      setState(() {
        _currentFrame =
            (_currentFrame - steps) % widget.frames.length;
        if (_currentFrame < 0) _currentFrame += widget.frames.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.frames.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: const Center(
          child: Text('No frames available', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragEnd: _onDragEnd,
      onHorizontalDragUpdate: _onDragUpdate,
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ── Shadow ellipse neeche ──
            Positioned(
              bottom: 24,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _isDragging ? 190 : 180,
                height: 14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black.withOpacity(0.08),
                ),
              ),
            ),

            // ── Product Image ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 40),
                child: Image.network(
                  widget.frames[_currentFrame],
                  key: ValueKey(_currentFrame),
                  fit: BoxFit.contain,
                  height: widget.height - 40,
                  loadingBuilder: (_, child, prog) {
                    if (prog == null) return child;
                    return SizedBox(
                      height: widget.height - 40,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF3B6B5E),
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.chair,
                    size: 110,
                    color: Color(0xFFAAAAAA),
                  ),
                ),
              ),
            ),

            // ── Progress dots — frame position dikhate hain ──
            Positioned(
              bottom: 4,
              child: _FrameIndicator(
                totalFrames: widget.frames.length,
                currentFrame: _currentFrame,
              ),
            ),

            // ── Drag hint — sirf tab tak jab interact nahi kiya ──
            if (!_hasInteracted)
              Positioned(
                bottom: widget.height / 2 - 18,
                child: const _DragHintBadge(),
              ),

            // ── 360° badge top-right ──
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B6B5E).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: const Color(0xFF3B6B5E).withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.threesixty_rounded,
                        size: 14, color: Color(0xFF3B6B5E)),
                    SizedBox(width: 4),
                    Text(
                      '360°',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B6B5E)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Frame indicator dots ─────────────────────────────────────────────────────
class _FrameIndicator extends StatelessWidget {
  final int totalFrames;
  final int currentFrame;

  const _FrameIndicator({
    required this.totalFrames,
    required this.currentFrame,
  });

  @override
  Widget build(BuildContext context) {
    // Har 4th frame ke liye ek dot
    final dotCount = (totalFrames / 4).ceil();
    final activeDot = (currentFrame / 4).floor();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(dotCount, (i) {
        final isActive = i == activeDot;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: isActive ? 18 : 5,
          height: 4,
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF3B6B5E)
                : Colors.grey.withOpacity(0.35),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}

// ─── Drag hint animated badge ─────────────────────────────────────────────────
class _DragHintBadge extends StatefulWidget {
  const _DragHintBadge();

  @override
  State<_DragHintBadge> createState() => _DragHintBadgeState();
}

class _DragHintBadgeState extends State<_DragHintBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _slide = Tween<double>(begin: -8, end: 8).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _fade = Tween<double>(begin: 0.7, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Transform.translate(
        offset: Offset(_slide.value, 0),
        child: Opacity(
          opacity: _fade.value,
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded,
                    size: 11, color: Colors.white),
                SizedBox(width: 6),
                Text('Drag to rotate',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 11, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}